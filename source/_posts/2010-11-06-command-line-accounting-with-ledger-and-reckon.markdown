---
layout: post
title: "How I do command-line accounting: Ledger and Reckon"
alias: "/post/1503439483/command-line-accounting-with-ledger-and-reckon"
date: 2010-11-06 18:03
comments: true
categories: [tools, machine learning]
---

<p>Ledger is a powerful yet simple double-entry accounting system with a command line interface, making it perfect for those of us who prefer our text editor and flat files over any confusing and inflexible accounting program.</p>



<p>I&#8217;ve been using Ledger for about a year now, including for balancing last year&#8217;s budget.  In the process, I&#8217;ve needed both to import CSV files of financial data from various sources and to label that data with the most appropriate account.  To do this, I&#8217;ve written a Ruby gem called <a href="https://github.com/iterationlabs/reckon">Reckon</a> that can usually guess bank data CSV headings, and can also use <a href="http://en.wikipedia.org/wiki/Bayesian_inference">Bayesian learning</a> to automatically categorize each entry.  I think of this as Mint for the command line, but where you don&#8217;t have to trust a 3rd party with your bank account passwords.</p>



<p>Getting started with Ledger is pretty easy.  I recommend skimming the <a href="http://cloud.github.com/downloads/jwiegley/ledger/ledger.pdf">official documentation (pdf)</a>.</p>



<p>I usually start out the year by making a new year.dat file and entering my business bank account&#8217;s starting balance:</p>



<pre><div style="font-size: 0.9em; background-color: #e6e6e6;">2010/01/01 * Checking

  Assets:Bank:Checking            $5.000.00

  Equity:Opening Balances

</div></pre>



<p>Next, I run Reckon on a CSV dump file from my bank:<br/><code>reckon -f bank.csv -p</code>

</p>



<p>If the output looks reasonable, I convert to ledger format and label everything:</p>



<style>

pre div.reckon i { font-style: italic; color: #999; }

</style><pre><div style="font-size: 0.75em; overflow: auto; padding: 2px; background-color: #e6e6e6;" class="reckon">$ reckon -f bank.csv -o output.dat

What is the account name of this bank account in Ledger? |Assets:Bank:Checking|

<i>(Here I accept the default because I want to have all money flowing

in and out of my bank account.)</i>

+------------+--------+--------------------------+

| 2010/03/13 |  $100.00 | GOOGLE ADSENSE REVENUE |

+------------+--------+--------------------------+

Which account provided this income? ([account]/[q]uit/[s]kip) Income:Adsense

<i>(I decided to call this Income:Adsense.)</i>

+------------+---------+-----------------------------+

| 2010/03/14 | -$10.00 | FEE: INCOMING DOMESTIC WIRE |

+------------+---------+-----------------------------+

To which account did this money go? ([account]/[q]uit/[s]kip) |Income:Adsense| Expenses:Bank Fees

+------------+-----------+-----------------------+

| 2010/03/14 |  $1000.00 | WIRE TRANSFER DEPOSIT |

+------------+-----------+-----------------------+

Which account provided this income? ([account]/[q]uit/[s]kip) |Expenses:Bank Fees| Income:Various Sales

<i>(Reckon guessed <code>Expenses:Bank Fees</code>, but I decided 

to call this <code>Income:Blogging</code>.)</i>

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;+

| 2010/03/28 |  $300.00 | GOOGLE ADSENSE REVENUE  |

+&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;+&#8212;&#8212;&#8212;&#8212;&#8212;+&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-+

Which account provided this income? ([account]/[q]uit/[s]kip) |Income:Adsense|

<i>(Notice how this time it guessed <code>Income:Adsense</code> correctly.)</i>

…

</div></pre>



Now, my output.dat file looks something like:



<pre><div style="font-size: 0.9em; background-color: #e6e6e6;">2010/01/01 * Checking

    Assets:Bank:Checking               $5.000.00

    Equity:Opening Balances



2010/03/13    GOOGLE ADSENSE REVENUE

    Assets:Bank:Checking               $100.00

    Income:Adsense                    -$100.00



2010/03/14    FEE: INCOMING DOMESTIC WIRE

    Expenses:Bank Fees                 $10.00

    Assets:Bank:Checking              -$10.00



2010/03/14    WIRE TRANSFER DEPOSIT

    Assets:Bank:Checking               $1000.00

    Income:Blogging                   -$1000.00



2010/03/28    GOOGLE ADSENSE REVENUE

    Assets:Bank:Checking               $300.00

    Income:Adsense                    -$300.00

</div></pre>



And if I run Ledger on it, I can get a breakdown:



<pre><div style="font-size: 0.9em; background-color: #e6e6e6;">$ ledger -f output.dat balance

            $6390.00  Assets

           $-5000.00  Equity

              $10.00  Expenses

           $-1400.00  Income



$ ledger -f output.dat equity

2010/11/06 Opening Balances

    Assets:Bank:Checking                    $6390.00

    Equity:Opening Balances                $-5000.00

    Expenses:Bank Fees                        $10.00

    Income:Adsense                          $-400.00

    Income:Blogging                        $-1000.00

                                                   0

</div></pre>



<p>Notice that the income is negative because the money flowed from the income source (Google and Blogging) to the destination (my bank account).  This is double entry accounting, so the final sum is always zero, as seen in the last row.</p>



<p>Finally, later in the year when there is new financial data, I want Reckon to learn from my existing .dat file, so I do:</p>



<pre><div style="font-size: 0.9em">reckon -f bank.csv -l 2010.dat -o output.dat</div></pre>



<p>To install Ledger and Reckon, see their Github pages:<br/><a href="https://github.com/iterationlabs/reckon"><a href="https://github.com/iterationlabs/reckon">https://github.com/iterationlabs/reckon</a></a><br/><a href="https://github.com/jwiegley/ledger"><a href="https://github.com/jwiegley/ledger">https://github.com/jwiegley/ledger</a></a></p>
