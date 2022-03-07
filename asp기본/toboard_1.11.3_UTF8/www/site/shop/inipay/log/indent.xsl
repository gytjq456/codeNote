<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

    <xsl:output method='xml' indent='yes' omit-xml-declaration='yes'/>

    <xsl:template match="@* | node()">

        <xsl:copy>

            <xsl:apply-templates select="@* | node()"/>

        </xsl:copy>

    </xsl:template>

</xsl:stylesheet>

