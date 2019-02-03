---
layout: post
title: "Why Security Expectations Matter: Hidden Content is Readable in Shared Google Sheets"
date: 2019-01-27 11:30:00 -0700
comments: true
---
This post describes a security design flaw that I found last year in Google Sheets. While this isn't a traditional security bug, it could still create vulnerability for users and is a good example of how surprising behavior can violate users' security expectations. In summary: contrary to the expectation set by the UI, both hidden columns and hidden sheets in shared Google Sheets documents can be viewed by anyone who can access the document, even by read-only users when exports are disabled. For public documents, this means anyone can see information that the owner may have intended to hide from view.

# Responsible Disclosure

As with my [previous](/blog/2011/12/14/hacking-google-for-fun-and-profit) Google-related security findings, this issue was responsibly disclosed to Google prior to publication. Google informed me that they have opted not to resolve this issue.

# The Issue

Imagine that you have a document with sensitive financial information that you want to share in aggregate. As Google Sheets supports hiding columns or entire sheets, it might be natural to hide the sheet (or column) containing sensitive data, make a visible sheet containing only calculated summary statistics from the data, and share the document as view-only with export disabled. If you checked in a logged out browser, you'd see that your hidden columns and sheets were not visible to the view-only user. I’d certainly forgive you for thinking that sharing was perfectly safe, but it turns out a determined individual could still read all of your hidden sensitive information.

Like Excel, Google Sheets documents have the concept of hidden columns and hidden sheets. Any column can be hidden by selecting "Hide column" from the column’s dropdown menu. Similarly, whole sheets of the document can be hidden by selecting "Hide sheet" from their dropdowns.

Hiding is not necessarily intended as a security feature; in an editable document, any editor can simply unhide the column/sheet. This behavior is consistent across Excel and Google Sheets. Moreover, when exporting Google Sheets documents to another format like CSV, the hidden content is included.

Unlike Excel, however, Google Sheets makes it very easy to share a document publicly in view-only format with the ability to “download, print, and copy for commenters and viewers” disabled. When shared this way, both hidden columns and hidden sheets cannot be viewed in the UI by users with view-only permissions. Instead, they appear disabled, as seen here:

{% img /images/posts/security/google-sheets/hidden-page-example.png %}

While the ability to hide columns and sheets was originally intended as a convenience feature, and not a security feature, this disabled UI behavior gives a document owner an impression of security. With the ability to make documents non-exportable and view-only, it is easy to believe that data in your hidden sheets and columns is protected. This expectation could lead a document owner to believe it is safe to share documents that contain sensitive information in hidden columns or sheets.

However, there are at least two ways for view-only users to see the content of hidden columns and sheets -- even without the ability to export the document. One is as simple as inspecting the HTML document source, and the other, while requiring use of Chrome's Developer Tools, would be trivial for an interested party to learn. It’s easy to imagine making this mistake with sensitive company data, or even social security numbers. This would be a bad idea in many ways, but unfortunately is not an unlikely mistake for someone to make. And that’s the point: security expectations matter.

## Details

I found two different ways to view the contents of hidden columns and sheets while in view-only mode and without access to file export.

### Viewing the source

For hidden columns in the first sheet of a document, seeing their data is as simple as viewing the document source. The `og:description` meta property of the document contains a text-only version of the first sheet, including the text of any hidden columns:

{% img /images/posts/security/google-sheets/google-sheets-header.png %}

### Modifying requests

To view the contents of hidden sheets, or of hidden columns not in the first sheet, you need to do slightly more.

Using Chrome’s Developer Tools, look at the network requests made when visiting a Google Sheet document. There will be multiple requests to a `streamrows` endpoint. These requests can be modified to change the `chunks` POST parameter and view data from hidden sheets and columns. To do this, right click on one of the `streamrows` requests and select "Copy" -> "Copy as cURL", paste it into a terminal, and edit the `chunks` parameter to be `%5B%22GID%22%5D`, replacing `GID` here with the gid of a hidden sheet. To find the gid for a hidden sheet, look in the `bootstrapData` structure provided in the main HTML page’s source. The gids for all sheets, including hidden ones, will be present near the top in blocks like `[null,2,0,"97859573",[null,[[null,0,0,"Hidden Sheet"] ...`. In this case, the gid is `97859573`. The response to the modified `streamrows` POST request will contain the text of the hidden sheet.

# Google's Response

Google decided that the current behavior of hidden columns and sheets is not a security issue, responding that “hidden sheets is not a security measure.” Google has every right to decide how they want their products to behave. However, they cannot control user expectations. My opinion is with the current UI, many users would expect hidden sheets and columns to be inaccessible to read-only viewers. These users may be unpleasantly surprised to learn otherwise.

Unfortunately, Google has a track record of not changing features that, while not explicitly security vulnerabilities, violate user expectation and thus lead to data compromise. In 2014, I reported to Google an example of [poor security communication in the Google Auth flow](/blog/2014/09/08/example-of-poor-security-communication-in-google-auth-flow) that they opted not to fix. In that case, when authorizing an external OAuth application or Google Apps Script, users were not clearly told that they were allowing 3rd party access to their data, making social engineering attacks where an attacker could name their malicious application something benign far too easy. The issue [resurfaced in 2017 as an active attack](https://www.reddit.com/r/netsec/comments/693hkc/todays_google_docs_phishing_incident_attack/) and [someone found my original post and wondered why it wasn't fixed years before](https://twitter.com/cglyer/status/860051133196374016).

I would recommend that Google either allow read-only users easy access to hidden content, setting no expectation of security, or change their implementation to not allow access to hidden content via the HTML source or web requests for read-only users. I hope that Google decides to change this behavior before someone accidentally leaks sensitive information.
