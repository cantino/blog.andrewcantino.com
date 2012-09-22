---
layout: post
title: "Compressing Code"
date: 2012-06-15 21:15
comments: true
categories: [code, ideas, data]
---
<div class='empty'>
  <script type="text/javascript" src="http://www.google.com/jsapi"></script>
  <script type="text/javascript">
    google.load('visualization', '1', {packages: ['corechart']});
  </script>
  <script type="text/javascript">
    function drawVisualization() {
      var languageData = {
        Ruby: [
          ["octopress",3.109],
          ["homebrew",3.310],
          ["will_paginate",3.724],
          ["jekyll",3.909],
          ["cucumber",3.976],
          ["compass",4.076],
          ["bundler",4.087],
          ["sinatra",4.096],
          ["gollum",4.126],
          ["refinerycms",4.215],
          ["resque",4.217],
          ["ruby",4.217],
          ["diaspora",4.285],
          ["active_admin",4.452],
          ["spree",4.634],
          ["devise",4.961],
          ["paperclip",5.087],
          ["rails_admin",5.276],
          ["rails",5.327],
          ["capybara",5.335],
          ["cancan",5.434],
          ["authlogic",5.666],
          ["fog",5.787],
          ["mongoid",6.714]
        ],

        CPP: [
          ["v8",3.031],
          ["node",3.049],
          ["bitcoin",4.037],
          ["wkhtmltopdf",4.081],
          ["mongo",4.264],
          ["scribe",4.504],
          ["mysql",4.977],
          ["doom3.gpl",5.024],
          ["phantomjs",5.501]
        ],

        Java: [
          ["hudson",4.558],
          ["hadoop",4.952],
          ["grails-core",5.466],
          ["clojure",5.930],
          ["cassandra",6.601],
          ["netty",6.692],
          ["voldemort",6.986],
          ["spring-framework",7.043],
          ["storm",9.340]
        ],

        JS: [
          ["Skeleton",1.648],
          ["mustache.js",2.838],
          ["impress.js",3.102],
          ["pdf.js",3.245],
          ["three.js",3.371],
          ["underscore",3.410],
          ["zepto",3.505],
          ["raphael",3.614],
          ["backbone",3.630],
          ["history.js",3.752],
          ["UglifyJS",3.788],
          ["headjs",3.866],
          ["scriptaculous",4.044],
          ["less.js",4.105],
          ["handlebars.js",4.199],
          ["jquery",4.202],
          ["ace",4.207],
          ["bootstrap",4.219],
          ["d3",4.413],
          ["prototype",4.511],
          ["ember.js",4.549],
          ["jasmine",4.872],
          ["async",4.978],
          ["express",5.145],
          ["mongoose",5.735],
          ["socket.io",6.719]
        ],

        PHP: [
          ["WordPress",4.373],
          ["twitteroauth",4.408],
          ["pyrocms",4.559],
          ["foundation",5.067],
          ["Slim",5.552],
          ["symfony",6.337],
          ["zf2",6.580],
          ["cakephp",6.839]
        ],

        C: [
          ["git",3.758],
          ["redis",4.194],
          ["memcached",4.539],
          ["ccv",4.659],
          ["linux",4.847],
          ["yajl",4.983],
          ["nginx",5.352],
          ["php-src",8.752]
        ],

        Python: [
          ["webpy",2.943],
          ["fabric",3.573],
          ["reddit",3.587],
          ["blueprint",3.962],
          ["tornado",4.279],
          ["flask",4.415],
          ["django",4.901]
        ]
      };

      var summary = [
        ["Python",3.952],
        ["JS",4.064],
        ["CPP",4.274],
        ["Ruby",4.584],
        ["C",5.136],
        ["PHP",5.464],
        ["Java",6.396]
      ];

      var crossLanguageSummary = google.visualization.arrayToDataTable([["", ""]].concat(summary.reverse()));
      new google.visualization.BarChart(jQuery("#cross-language").get(0)).draw(crossLanguageSummary,
            {title:"Average Compressability by Language",
              width: 400, height: 300,
              legend: { position: "none" },
              chartArea: { width: "80%", height: "80%" }
            });


      jQuery.each(languageData, function(name, value) {
        var data = google.visualization.arrayToDataTable([["", ""]].concat(languageData[name].reverse()));
        var $elem = jQuery("<div></div>").addClass("visualization").addClass(name).css({ width: "600px", height: "400px", display: "none" });
        jQuery("#visualizations").append($elem);
        jQuery("#viz-links").append(jQuery('<a href="#"></a>').text(name).click(function(e) {
          e.preventDefault();
          jQuery("#visualizations .visualization").hide();
          $elem.show();
          return false;
        }));

        new google.visualization.BarChart($elem.get(0)).draw(data,
               {title:"Compressability of " + name + " Libraries",
                width: 600, height: 500,
                legend: { position: "none" },
                hAxis: { maxValue: 7, minValue: 2, viewWindowMode: 'explicit', viewWindow: { max: 7, min: 2 } },
                chartArea: { width: "70%", height: "75%" }
               });
      });

      jQuery("#visualizations .visualization.Ruby").show();
    }

    google.setOnLoadCallback(drawVisualization);
  </script>

  <style>
    .empty {
      width: 0;
      height: 0;
      padding: 0;
      margin: 0;
    }

    #viz-links a {
      padding: 10px;
    }

    #visualizations {
      width: 600px;
      height: 500px;
    }

    #cross-language {
      width: 400px;
      height: 300px;
    }

    .cross-language-wrapper {
      margin: 8px 20px 10px 20px;
      float: right;
      width: 385px;
      height: 355px;
      padding-left: 5px;
      font-size: 13px;
      font-style: italic;
      text-align: center;
      overflow: hidden;
      background-color: white;
    }

    .box {
      box-shadow: 2px 2px 9px #999;
      border: 1px solid #999;
    }

    .results {
      clear: both;
      margin: 10px;
      padding: 10px;
      width: 600px;
      overflow: hidden;
      height: 500px;
    }
  </style>
</div>

What can we learn about a code base or a language based on its compressibility?  My pet theory is that less compressible code will be, on average, better code, because less compressible code implies more factoring, more reuse, and fewer repetitions.

<div class='cross-language-wrapper box'>
  <div id='cross-language'></div>
  <div>
    Larger numbers (longer lines) indicate more compressibility.
  </div>
</div>

Below are the compressibility results for some popular libraries and languages.  To generate this data, I downloaded each package or library, extracted the source files, removed comments, and gzipped the files with maximum compression.  The numbers represent the ratio of uncompressed source file size to compressed source file size.  Smaller ratios imply less compressible code.

Unsurprisingly, Java was the most compressible language- all that boilerplate!  Python was the least compressible language, with Java, on average, being about twice as compressible.  I was somewhat surprised that JavaScript was the second best language in terms of incompressibility.

It's probably disingenuous to draw strong conclusions from these results, but I still find them intriguing.  What, if anything, do you think they mean?

<div class='results box'>
  <div id="viz-links">
    <span>View data for:</span>
  </div>

  <div id="visualizations"></div>
</div>

<br />

<strong>Aside:</strong> Compression itself is a fascinating subject.  Being able to compress something is fundamental to being able to understanding it.  If you can rewrite a 2 page document into 2 paragraphs, while still expressing its core ideas, you've deeply understood the material.  Hence the existence of the [Hutter Prize](http://en.wikipedia.org/wiki/Hutter_Prize), a standing challenge in Artificial Intelligence to further compress a corpus of English text.  Hence, also, the existence of [specialized image compression algorithms](http://www.cs.technion.ac.il/~elad/publications/journals/2007/FaceCompress_KSVD_JVCIR.pdf) that compress human faces better than anything else because they understand, in software, what a human face generally looks like.

If I can compress an image of your face, I can probably also recognize it.  Imagine that I have thousands of photos of faces.  Using some linear algebra and creative encodings, I can figure out the commonalities and differences among these faces.  Basically, I can derive a set of common noses, a set of common eyes, a set of common brows... and, given a new face photo, I can compute a mixture of these common attributes for the new face.  Perhaps it, roughly speaking, has 60% of Common Nose 6 and 40% of Common Nose 12.  Well, then I can represent the picture of this new nose as roughly two numbers, the "amounts" of Nose 6 and of Nose 12, and suddenly I've compressed a collection of hundreds or thousands of pixels- a photo of a nose- into just two numbers.  We could also go in reverse, taking a photo, calculating the percentages of different common features, and then looking up in a database to see who we know whose face expresses those same feature percentages.  We can compress, and, thus, we can recognize.  (Interested in this?  See [Eigenfaces](http://en.wikipedia.org/wiki/Eigenface) as well as [PCA and ICA for face analysis](http://www.face-rec.org/algorithms/Comparisons/draper_cviu.pdf).)
