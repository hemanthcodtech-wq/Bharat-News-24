<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:html="http://www.w3.org/TR/REC-html40"
    xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
      <head>
        <title>XML Sitemap - Bharath 24 News</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <style type="text/css">
          body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
            color: #1e293b;
            margin: 0;
            padding: 30px 16px;
            background: #f1f5f9;
          }
          .container {
            max-width: 1050px;
            margin: 0 auto;
            background: #ffffff;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.08), 0 2px 4px -1px rgba(0, 0, 0, 0.04);
          }
          .header {
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 20px;
            margin-bottom: 24px;
          }
          h1 {
            color: #E10600;
            font-size: 26px;
            margin: 0 0 8px 0;
            font-weight: 800;
            letter-spacing: -0.02em;
          }
          p.desc {
            color: #64748b;
            font-size: 14px;
            margin: 0;
            line-height: 1.6;
          }
          .count-badge {
            background: #0A1E3F;
            color: #ffffff;
            padding: 2px 8px;
            border-radius: 6px;
            font-weight: 700;
            font-size: 12px;
          }
          table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
          }
          th {
            background-color: #0A1E3F;
            color: #ffffff;
            text-align: left;
            padding: 12px 14px;
            font-weight: 600;
            font-size: 13px;
          }
          th:first-child { border-top-left-radius: 8px; }
          th:last-child { border-top-right-radius: 8px; }
          td {
            padding: 10px 14px;
            border-bottom: 1px solid #f1f5f9;
            word-break: break-all;
          }
          tr:nth-child(even) {
            background-color: #f8fafc;
          }
          tr:hover {
            background-color: #f1f5f9;
          }
          a {
            color: #1e40af;
            text-decoration: none;
            font-weight: 500;
          }
          a:hover {
            text-decoration: underline;
            color: #E10600;
          }
          .badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
            background: #fee2e2;
            color: #991b1b;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>XML Sitemap — Bharath 24 News</h1>
            <p class="desc">
              This is the official XML Sitemap for search engines (Google, Bing). Total indexed entries: <span class="count-badge"><xsl:value-of select="count(sitemap:urlset/sitemap:url)"/> URLs</span>
            </p>
          </div>
          <table>
            <thead>
              <tr>
                <th style="width: 55%;">URL</th>
                <th style="width: 15%;">Priority</th>
                <th style="width: 15%;">Change Frequency</th>
                <th style="width: 15%;">Last Modified</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="sitemap:urlset/sitemap:url">
                <tr>
                  <td>
                    <a href="{sitemap:loc}"><xsl:value-of select="sitemap:loc"/></a>
                  </td>
                  <td>
                    <span class="badge"><xsl:value-of select="sitemap:priority"/></span>
                  </td>
                  <td>
                    <xsl:value-of select="sitemap:changefreq"/>
                  </td>
                  <td>
                    <xsl:value-of select="substring(sitemap:lastmod, 0, 11)"/>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
