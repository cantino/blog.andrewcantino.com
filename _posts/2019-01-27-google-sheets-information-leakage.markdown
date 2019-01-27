---
layout: post
title: "Google Sheets Information Leakage"
date: 2019-01-27 11:30:00 -0700
comments: true
---
This post describes a security design flaw that I found last year in Google Sheets: both hidden columns and hidden pages in shared documents can be viewed by anyone who can access the document.

# Responsible Disclosure

As with my [previous](/blog/2011/12/14/hacking-google-for-fun-and-profit) Google-related security findings, this issue was responsibly disclosed to Google prior to publication. Google opted not to change this behavior.

# The Issue

Google Sheet documents have the concepts of hidden columns and hidden pages. Any column can be hidden by selecting "Hide column" from the column's dropdown menu. In a document shared as read-only, the UI indicates the existence of the hidden column, but does not let the user view it. Similarly, whole pages of the document can be hidden by selecting "Hide sheet" from their dropdowns. These too cannot be viewed in a shared read-only document, as seen here:

{% img /images/posts/security/google-sheets/hidden-page-example.png %}

It's clear that the ability to hide columns and pages was originally intended as a convenience feature, not a security feature. Given that, it's not surprising that hidden columns are visible in exports, such as when exporting a page in CSV format, and hidden pages are visible in exported XLS documents.

However, Google Sheets also contains a feature to prevent document export. Selecting the "Disable options to download, print, and copy for commenters and viewers" option when sharing disables duplication and download of a Google Sheet. You can probably see where this is going. Now it is very reasonable for users to have the expectation that hidden columns and pages in a shared document are private, as viewers cannot directly download the document to local file formats, nor can they view the hidden data in the browser UI. It then seems perfectly safe to share documents that contain sensitive information in hidden columns or pages without concern. This would be a mistake, as there are at least two ways for read-only users to view the content of hidden columns and pages without the ability to export the document. One is as simple as viewing the document source.

Imagine you have a document with sensitive financial information that you want to share in aggregate. It would be very natural to hide the page (or column) containing sensitive data, make a visible page containing only calculated summary statistics from the data, and share the document with export disabled. I'd certainly forgive you for thinking that this was perfectly safe, but an attacker could actually still read all of your hidden sensitive information. It's easy to imagine companies having their financials stolen this way. Or, even worse, someone might make the mistake of hiding a column of social security numbers in a shared document. This would be a bad idea in so many ways, but unfortunately not that unlikely. And that's the point. Security expectations matter.

## Details

I found two different ways to view the contents of hidden columns and pages without access to file export.

### Viewing the source

For hidden columns in the first page of a document, seeing their data is as simple as viewing the document source. The `og:description` meta property of the document contains a text-only version of the first page, including the text of any hidden columns:

{% img /images/posts/security/google-sheets/google-sheets-header.png %}

### Modifying requests

To view the contents of hidden pages or hidden columns not in the first page, you need to do slightly more.

Using Chrome's Developer Tools, look at the network requests made when visiting a Google Sheet document. There will be multiple requests to a `streamrows` endpoint. These requests can be modified to change the `chunks` POST parameter and view data from hidden pages and columns. To do this, right click on one of the `streamrows` requests and select "Copy" -> "Copy as cURL", paste it into a terminal, and edit the `chunks` parameter to be `%5B%22GID%22%5D`, replacing GID with the gid of a hidden page. To find the gid for a hidden page, look in the `bootstrapData` structure provided in the main HTML page's source. The gids for all pages, including hidden ones, will be present near the top in blocks like `[null,2,0,"97859573",[null,[[null,0,0,"Hidden Sheet"]`. In this case, the gid is `97859573`. The response to the modified `streamrows` POST request will contain the text of the hidden page.

# Google's Response

Google decided that the current behavior of hidden columns and pages is not a security issue, responding that "hidden sheets is not a security measure." Google has every right to decide how they want their products to behave, but they can't control user expectation. My opinion is that many users will be surprised that hiding pages and columns does not make them inaccessible to read-only viewers. I was personally surprised that they were in exports, let alone that they are still accessible via Developer Tools even when exports are disabled.

Unfortunately, Google has a track record of not changing features that, while not explicitly security vulnerabilities, violate user expectation and thus lead to data compromise. In 2014, I reported to Google an example of [poor security communication in the Google Auth flow](/blog/2014/09/08/example-of-poor-security-communication-in-google-auth-flow) that they opted not to fix. In that case, when authorizing an external OAuth application or Google Apps Script, users were not clearly told that they were allowing a 3rd party access to their data until too late, making social engineering attacks far too easy. The issue [resurfaced in 2017](https://www.reddit.com/r/netsec/comments/693hkc/todays_google_docs_phishing_incident_attack/) and [someone found my original post and wondered why it wasn't fixed years before](https://twitter.com/cglyer/status/860051133196374016).

I hope Google decides to change this behavior before someone accidentally leaks sensitive information.
