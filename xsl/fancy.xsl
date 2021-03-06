<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:transform
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xalan="http://xml.apache.org/xslt"
  extension-element-prefixes="xalan">

  <xsl:output method="html"
    indent="yes"
    doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:variable name="STARJ_URL"
    select="'http://www.sable.mcgill.ca/~bdufou1/starj/'"/>

  <xsl:template name="make_anchor">
    <xsl:param name="sample_space_index"/>
    <xsl:param name="metric_space_index"/>
    <xsl:param name="category_index" select="-1"/>
    <xsl:choose>
      <xsl:when test="$category_index &gt;= 0">
        <xsl:value-of select="concat('s', $sample_space_index, 'm', $metric_space_index, 'c', $category_index)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('s', $sample_space_index, 'm', $metric_space_index)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/benchmark">
    <html>
      <head>
        <title>*J Metrics Page</title>
        <!--<link rel="Stylesheet" type="text/css" href="fancy.css"/>-->
        <style type="text/css">
        <xsl:comment>
          BODY, TD, TH, P, LI {
            FONT-FAMILY: Arial,Helvetica,Geneva,Sans-Serif;
          }

          PRE, CODE {
            FONT-FAMILY: Courier,Monospace;
          }

          BODY {
            BACKGROUND: #A2A095;
            COLOR: #00002F;
            MARGIN-LEFT: 3mm;
            MARGIN-RIGHT: 3mm;
          }

          .title {
            FONT-STYLE: italic;
          }

          .toc_title {
            BACKGROUND-COLOR: #00002F;
            COLOR: #FFFFFF;
          }

          .toc_contents {
            BACKGROUND-COLOR: #DDDFD7;
            COLOR: #00002F;
          }

          .contents_title {
            BACKGROUND-COLOR: #00002F;
            COLOR: #FFFFFF;
          }

          .contents {
            BACKGROUND-COLOR: #DDDFD7;
            COLOR: #00002F;
          }

          .bin_title {
            BACKGROUND-COLOR: #00002F;
            COLOR: #FFFFFF;
          }

          .bin {
            BACKGROUND-COLOR: #DDDFD7;
            COLOR: #00002F;
          }

          .bin_row2 {
            BACKGROUND-COLOR: #F6F4ED;
          }

          .metric_space {
            BACKGROUND-COLOR: #A2A095;
            COLOR: #00002F;
            FONT-WEIGHT: bold;
            TEXT-ALIGN: center;
          }

          .metric_name {
            font-weight: bold;
          }

          .metric_value {
          }

          A:link {
            COLOR: #AD2C2C;
          }

          A:hover {
            COLOR: #DC3838;
          }

          A:visited {
            COLOR: #00005F;
          }

          hr {
            WIDTH: 75%;
          }

          .footnote {
            FONT-SIZE: 50%;
          }
        </xsl:comment>
        </style>
      </head>
      <body>
        <center>
          <h1 class="title">
            <a href="{$STARJ_URL}">*J</a> Metrics Page
          </h1>
        </center>

        <!-- Create 2 columns -->
        <table class="topLevel" border="0" cellpadding="0" cellspacing="5">
          <tr valign="top">
            <td>
              <!-- 1st column -->
              <xsl:apply-templates select="./sample-space" mode="toc"/>
            </td>
            <td>
              <!-- 2nd column -->
              <xsl:apply-templates select="./sample-space" mode="contents"/>
            </td>
          </tr>
        </table>
        
        <center><hr/></center>
        <span class="footnote">Generated by
            <a href="{$STARJ_URL}">*J</a></span>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="sample-space" mode="toc">
    <table 
        class="toc_title"
        border="0"
        cellpadding="1"
        cellspacing="0"
        width="100%">
      <tr>
        <th><xsl:value-of select="@name"/></th>
      </tr>
      <tr>
        <td>
          <table
              class="toc_contents"
              border="0"
              bgcolor="#FFFFFF"
              cellpadding="0"
              cellspacing="5"
              width="100%">
            <tr>
              <td>
                <ul>
                  <xsl:apply-templates select="./metric-space" mode="toc">
                    <xsl:with-param name="sample_space" select="position()"/>
                  </xsl:apply-templates>
                </ul>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <br/>
  </xsl:template>

  <xsl:template match="metric-space" mode="toc">
    <xsl:param name="sample_space"/>
    <li>
      <a>
        <xsl:attribute name="href">#<xsl:call-template name="make_anchor">
          <xsl:with-param name="sample_space_index" select="$sample_space"/>
          <xsl:with-param name="metric_space_index" select="position()"/>
        </xsl:call-template>
        </xsl:attribute>
        <xsl:value-of select="@name"/>
      </a>
      <ul>
        <xsl:apply-templates select="./metrics" mode="toc">
          <xsl:with-param name="sample_space" select="$sample_space"/>
          <xsl:with-param name="metric_space" select="position()"/>
        </xsl:apply-templates>
      </ul>
    </li>
  </xsl:template>

  <xsl:template match="metrics" mode="toc">
    <xsl:param name="sample_space"/>
    <xsl:param name="metric_space"/>
    <xsl:apply-templates select="./category" mode="toc">
      <xsl:with-param name="sample_space" select="$sample_space"/>
      <xsl:with-param name="metric_space" select="$metric_space"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="category" mode="toc">
    <xsl:param name="sample_space"/>
    <xsl:param name="metric_space"/>
    <xsl:variable name="CATEGORY_NAME"><xsl:value-of select="@name"/></xsl:variable>
    <li>
      <a>
        <xsl:attribute name="href">#<xsl:call-template name="make_anchor">
          <xsl:with-param name="sample_space_index" select="$sample_space"/>
          <xsl:with-param name="metric_space_index" select="$metric_space"/>
          <xsl:with-param name="category_index" select="position()"/>
        </xsl:call-template></xsl:attribute>
        <!--
        <xsl:attribute name="href">#<xsl:value-of select=
            "concat('s', $sample_space, 'm', $metric_space, 'c', position())"/>
        </xsl:attribute>
        -->
        <xsl:value-of select="$CATEGORY_NAME"/>
      </a>
    </li>
  </xsl:template>

  <xsl:template match="sample-space" mode="contents">
    <table
        class="contents_title"
        border="0"
        cellpadding="1"
        cellspacing="0"
        bgcolor="#1D88C0"
        width="100%">
      <tr>
        <th>Subdivision scheme: <xsl:value-of select="@name"/></th>
      </tr>
      <tr>
        <td>
          <table
              class="contents"
              border="0"
              cellpadding="0"
              cellspacing="0"
              bgcolor="#FFFFFF"
              width="100%">
            <xsl:apply-templates select="./metric-space" mode="contents">
              <xsl:with-param name="sample_space" select="position()"/>
            </xsl:apply-templates>
          </table>
        </td>
      </tr>
    </table>
    <br/>
  </xsl:template>

  <xsl:template match="metric-space" mode="contents">
    <xsl:param name="sample_space"/>
    <tr class="metric_space" bgcolor="#DFDFDF">
      <td>
        <a>
          <xsl:attribute name="name">
            <xsl:call-template name="make_anchor">
              <xsl:with-param name="sample_space_index" select="$sample_space"/>
              <xsl:with-param name="metric_space_index" select="position()"/>
            </xsl:call-template>
          </xsl:attribute>
          Metric space: <xsl:value-of select="@name"/>
        </a>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:apply-templates select="./metrics" mode="contents">
          <xsl:with-param name="sample_space" select="$sample_space"/>
          <xsl:with-param name="metric_space" select="position()"/>
        </xsl:apply-templates>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="metrics" mode="contents">
    <xsl:param name="sample_space"/>
    <xsl:param name="metric_space"/>
    <xsl:apply-templates select="./category" mode="contents">
      <xsl:with-param name="sample_space" select="$sample_space"/>
      <xsl:with-param name="metric_space" select="$metric_space"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="category" mode="contents">
    <xsl:param name="sample_space"/>
    <xsl:param name="metric_space"/>
    <a>
      <xsl:attribute name="name">
        <xsl:call-template name="make_anchor">
          <xsl:with-param name="sample_space_index" select="$sample_space"/>
          <xsl:with-param name="metric_space_index" select="$metric_space"/>
          <xsl:with-param name="category_index" select="position()"/>
        </xsl:call-template>
      </xsl:attribute>
    </a>
    <ul>
      <xsl:apply-templates select="./metric" mode="contents">
        <xsl:with-param name="category" select="@name"/>
      </xsl:apply-templates>
    </ul>
  </xsl:template>

  <xsl:template match="metric" mode="contents">
    <xsl:param name="category"/>
    <xsl:apply-templates select="./value|./percentile|./bins" mode="contents">
      <xsl:with-param name="category" select="$category"/>
      <xsl:with-param name="metric" select="@name"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="value|percentile|bins" mode="contents">
    <xsl:param name="category"/>
    <xsl:param name="metric"/>
    <xsl:variable name="kind" select="name()"/>
    <li>
      <b><span class="metric_name">
          <xsl:choose>
            <xsl:when test="$kind='bins'">
              <xsl:value-of select="concat($category, '.', $metric, '.bin')"/>:
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of
                  select="concat($category, '.', $metric, '.', $kind)"/>:
            </xsl:otherwise>
          </xsl:choose>
      </span></b>
      <xsl:apply-templates select="." mode="output"/>
    </li>
  </xsl:template>

  <xsl:template match="bins" mode="output">
    <br/>
      <center>
        <table 
            class="bin_title"
            border="0"
            cellpadding="1"
            cellspacing="0" 
            bgcolor="#1D88C0">
          <tr>
            <td colspan="5">
              <table 
                  class="bin"
                  border="0"
                  cellpadding="0"
                  cellspacing="0"
                  bgcolor="#FFFFFF"
                  width="100%">
                <tr class="bin_title">
                  <th>Bin</th>
                  <th>&#160;&#160;</th>
                  <th>Value</th>
                </tr>
                <xsl:apply-templates select="./bin" mode="make_row"/>
              </table>
            </td>
          </tr>
        </table>
      </center>
  </xsl:template>

  <xsl:template match="bin" mode="make_row">
    <xsl:choose>
      <xsl:when test="position() mod 2 = 1">
        <tr class="bin_row2" bgcolor="#EFEFEF">
          <xsl:apply-templates select="." mode="contents"/>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr clas="bin_row1">
          <xsl:apply-templates select="." mode="contents"/>
        </tr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="bin[@key_type='range']" mode="contents">
    <td><xsl:value-of select="@low_key"/><xsl:text> - </xsl:text>
        <xsl:value-of select="@high_key"/></td>
    <td/>
    <td align="right"><xsl:apply-templates select="." mode="output"/></td>
  </xsl:template>

  <xsl:template match="bin" mode="contents">
    <td><xsl:value-of select="@key"/></td>
    <td/>
    <td align="right"><xsl:apply-templates select="." mode="output"/></td>
  </xsl:template>

  <xsl:template match="value|percentile|bin" mode="output">
    <span class="metric_value">
      <xsl:apply-templates select="." mode="format"/>
    </span>
  </xsl:template>

  <xsl:template match="value[@type='density']|percentile[@type='density']|bin[@type='density']"
      mode="format">
    <xsl:value-of select="."/><xsl:text> / KBC</xsl:text>
  </xsl:template>

  <xsl:template match="value[@type='percent']|percentile[@type='percent']|bin[@type='percent']"
      mode="format">
    <xsl:variable name="val" select="."/>
    <xsl:value-of select="format-number($val, '0.000%')"/>
  </xsl:template>

  <xsl:template match="value|percentile|bin" mode="format">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:transform>
