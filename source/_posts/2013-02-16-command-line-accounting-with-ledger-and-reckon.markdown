---
layout: post
title: "Command Line Accounting with Ledger and Reckon, an update"
date: 2013-02-16 14:08
comments: true
categories: [tools, machine learning, ruby]
---
I've been using [ledger](http://ledger-cli.org/), combined with a custom Ruby gem called [reckon](https://github.com/cantino/reckon), to balance my small business's accounts for the last few years.  The command line, Bayesian statistics, and Double Entry Accounting!  What could be better?  Here's how I do it. 

First, I export the year's transaction history from Chase (in my case) and save it as a CSV file called `chase-2012.csv`.  It looks something like this:

    Type,Post Date,Description,Amount
	DEBIT,12/31/2012,"ODESK***BAL-27DEC12 650-12345 CA           12/28",-123.45
	DEBIT,12/24/2012,"ODESK***BAL-20DEC12 650-12345 CA           12/21",-123.45
	DEBIT,12/24/2012,"GH *GITHUB.COM     FP 12345 CA        12/23",-12.00

Then, I make a new ledger file called `2012.dat` and start it with:

    2012/01/01 * Checking
	    Assets:Bank:Checking            $10,000.00
	    Equity:Opening Balances

Where the `$10,000.00` is the hypothetical starting balance of my bank account on the first day of 2012.  Since I've been using ledger, this is just the balance of the account from the summary that I generated at the end of 2011.

Now, I run `reckon`, initially with the `-p` option to see its analysis of the CSV file:

    > reckon -f chase-2012.csv -v -p --contains-header
    
    What is the account name of this bank account in Ledger? |Assets:Bank:Checking| 
    I didn't find a high-likelyhood money column, but I'm taking my best guess with column 4.
    +------------+------------+----------------------------------------------------------+
    | Date       | Amount     | Description                                              |
    +------------+------------+----------------------------------------------------------+
    | ...        | ...        | ...                                                      |
    | 2012/12/24 | -$12.00    | DEBIT; GH *GITHUB.COM FP 12345 CA 12/23                  |
    | 2012/12/24 | -$123.45   | DEBIT; ODESK***BAL-20DEC12 650-12345 CA 12/21            |
    | 2012/12/31 | -$123.45   | DEBIT; ODESK***BAL-27DEC12 650-12345 CA 12/28            |
    +------------+------------+----------------------------------------------------------+

It looks like `reckon` has guessed the correct columns from the CSV, so now I run it in "learning" mode.  It loads in my data from 2011 and uses it to guess at labels for my 2012 data, using a simple Naive Bayes classifier.

    > reckon -f chase-2012.csv -v -o 2012.dat -l 2011.dat --contains-header
    
    ...
    +------------+---------+------------------------------------------------+
    | 2012/12/24 | -$12.00 | DEBIT; GH *GITHUB.COM FP 12345 CA 12/23        |
    +------------+---------+------------------------------------------------+
    To which account did this money go? ([account]/[q]uit/[s]kip) |Expenses:Web Hosting:Github| 
    +------------+----------+-------------------------------------------------+
    | 2012/12/24 | -$123.45 | DEBIT; ODESK***BAL-20DEC12 650-12345 CA 12/21   |
    +------------+----------+-------------------------------------------------+
    To which account did this money go? ([account]/[q]uit/[s]kip) |Expenses:Programming| 
    +------------+----------+-------------------------------------------------+
    | 2012/12/31 | -$123.45 | DEBIT; ODESK***BAL-27DEC12 650-12345 CA 12/28   |
    +------------+----------+-------------------------------------------------+
    To which account did this money go? ([account]/[q]uit/[s]kip) |Expenses:Programming|

In each of these cases, the Bayesian classifier correctly guessed the appropriate label for these expenses based on last year's data.

Now, with a fully-updated 2012.dat file, I run it through ledger and get the following hypothetical results:

    > ledger -f 2012.dat -s bal

        $20,000   Assets:Bank:Checking
       $-10,000   Equity:Opening Balances
        $258.90   Expenses
        $246.90     Programming
         $12.00     Web Hosting
         $12.00       Github
       $-10,258.90  Income
       $-10,258.90    Some source of income that makes this math work

I like to do all of this work inside of my Dropbox folder in case I delete or overwrite a file by mistake.

Want to do all of this yourself?  Start by visiting [ledger-cli.org](http://ledger-cli.org/), or by installing ledger with homebrew:
  
    > brew install ledger

Then install reckon:

    > (sudo) gem install reckon

Have fun!

[Reckon](https://github.com/cantino/reckon) is available on GitHub, and, for updates, you should [follow me on Twitter](https://twitter.com/tectonic).