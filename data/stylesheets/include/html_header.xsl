<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template name="html_header">
    <xsl:param name="title"/>
    <head>
      <meta http-equiv="Content-Language" content="en-au"/>
      <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
      <title>
        <xsl:value-of select="$title"/>
      </title>
      <style>
    body {padding-right: 0px; padding-left: 0px; font-size: 80%; background: #fff; padding-bottom: 0px; margin: 6px 12px; color: #000; padding-top: 0px; font-family: verdana, arial, sans-serif; text-align: left}
    p {font-size: 1em; margin: 5px 0px}
    td {font-size: 80%; padding:5px}
    td.smallfont {font-size: 8pt; padding:5px}
    ul {margin-top: 0px; margin-bottom: 0px}
    h1 {font-weight: 600; margin: 10px 0px 5px; color: #000080}
    h2 {font-weight: 600; margin: 10px 0px 5px; color: #000080}
    h3 {font-weight: 600; margin: 10px 0px 5px; color: #000080}
    h4 {font-weight: 600; margin: 10px 0px 5px; color: #000080}
    h1 {margin-top: 0px; font-size: 1.6em}
    h2 {font-size: 1.3em}
    h3 {font-size: 1.1em}
    h4 {font-size: 0.9em}
    a:link {color: blue}
    a:visited {color: purple}
    a:hover {background: #ccc}
    legend {color: navy}
    .grey {background-color="#F3F3F3"}    
    .agency {color: green}
    .SRNSW {color: red}  
    </style>
    </head>
  </xsl:template>
</xsl:stylesheet>
