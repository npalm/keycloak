<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ut="urn:jboss:domain:undertow:3.0"
                xmlns:domain="urn:jboss:domain:4.0">

    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="//ut:subsystem/ut:server[@name='default-server']">
        <ut:server name="default-server">
            <ut:http-listener name="default" socket-binding="http" proxy-address-forwarding="true"/>
            <ut:host name="default-host" alias="localhost">
                <ut:location name="/" handler="welcome-content"/>
                <ut:filter-ref name="server-header"/>
                <ut:filter-ref name="x-powered-by-header"/>
            </ut:host>
        </ut:server>
    </xsl:template>

    <xsl:template match="/domain:server/domain:socket-binding-group/domain:socket-binding[last()]">
        <xsl:copy-of select="."/>
        <domain:socket-binding name="proxy-https" port="443"/>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
