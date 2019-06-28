<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
    xmlns:umz="urn:unimaze.com:schemas:message-info-extension:v1" version="1.0">
    <xsl:template name="UnimazeHeader">
        <xsl:variable name="banner_validation_approved-32">
            iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAC6klEQVRYhbWXz0sWQRjHPy4eKkwMQthgICrEQ1gXI9uI/gClopPQqUz8EUSIRHToFBIeIt58JansYF0yqU4R5SEaC4qICAlP4UbjwUJMLEReOuzs67jsO7uL6/e088wz8/3O8zwzs1NFBni+2wr0AQ+BMSnUP23fApwB2oFBKdSLtHNWZSBvAD4Atdr0E7ipvy8Bu/T3ItAshZrJTYBe4TvgYEq9n4GWMEKZBXi+exw4CmwHaoAm3c6Ct8AXYAn4A0xJoSYTBXi+Ww38Yi3UeWEJ2CGFWjWNTozjvk0ghyCSDVFjnIDGTSCvOHecgKZNFHAgaijXgOe79cB14CzxwvJACXgAXJVCzZUFeL7bAQwCdTmQ/AZWgXqLzyJwRQpVrNJV/xeozoF8GWgGZgkW1GXxLQFbHb0tPuVADnBZCjUthVqSQnUDExbfj1KolTDXT3IgnwSKYcPz3VrgsMX/MawV2/gGyReBc1KokmG7wdr9EIcJU0AtQU5s+AGsVOjrl0J9Dxv6KO+0zFVCF7zj+a4DDGPfeuPAXqCNoNBMvAJGDPIa4F7CfA4w7Pmu4xBUqi1XU0C7FGpFCvUyIiIMvek/AOyxzBfiENDjAP0JjusuD32jtRFcLn1SqNmwT4e+JwV5iH6HoFhs+T8GjOpUmSKagbsGeZrQRzEQnoQ9QCFh8H3gfKTSy/B8twBcSElcAi5KoW6bd0EXQTHaMAJ0R0Xo0L8m/ep7pVBFIgPepBjYCQyZ6dAHzmgG8nVc5qCdKQd3AXcMEbeA3RnI13FVxxlToAPY7/nuHHAyI3lFAVlhOztSw0zBU+A0MAbM5zF5BPPAI81RviUr/ZY7QCvwLCfyU8DzuC1sfZh4viuBIxskfy+FaqnUmbR1Chskh2CXVESSgHHgK8HJNU1QH9eAhRjfBd03pn3DMdZ/jcS3oX4XOlKoZcPWSFAf4UNjBjghhfpm+GwDSknvw9Sv4xhhdcCQbvZKoeKikoj/Jg3eYQyYrq0AAAAASUVORK5CYII=
        </xsl:variable>

        <xsl:variable name="banner_validation_rejected-32">
            iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAADY0lEQVRYha2XW4hNURjHfzR58E0eJGklSZrkluQumqGUGUp5oLx4QFJueZAnL0R5cck9D3J94UU0lEsuY4hpCtM0SZJWk5g0zTdNk04e1tpjnzXr7LPPMf+Xs9f61vf///det++MogpYkQnALmALUABuAOeMak+lXKMqFK4FDgL7gNog3AucBE4Y1b4RNWBFADYDJ4DJ5YYDB4DbRvX/DViROuAMsKYsWzEeAbuNaldVBqzIJOAQsBMYU6F4gkHgHHDMqP4oa8CKLADmAQ3ABmBslcIh+oG7wFOg3ai2DTNgRTYDt0ZIsBy2GNWbADWpzjk5kwvAS+Ah8NlzTAGagGXA6Bwcs5KHtIFfORLbge1G9V0kdtxP4WXcNGZhSCtt4GeZpAfARqM6YEVGA/UpoTbguVF9Z0WWAneAxgyuIa20AZuR0Als8uLzgavA7IjBJj9mE/AeqCvB9z15SM/X1wwDB4xqnxWZiVvJobgF9gNYkTH+JNyfwTekFRoYjAz+BjT75/PAuCDeDaw2ql1WZCtwz/c3+9wQg+n+IQNG9Q/uU4d4ZlQLVmQasLKEeKcV2QZcAdZYkalGtQA8i/B1ea1iAx5tDEcyX+F8/vDiHVZkB3AxxZeMjX2BIo3QwKtIQnIM9wfiDV58J25q0lx/gtw0XqQbNUHwSSRhhv9tBwZw125D6s3PBuID/HvLmRG+Io2iL2BUvzB8HdRbkVqj2gscDcTDNwe4ZFR/+9qhPoh1eo24AY+7QbsWV/1gVI948a0lxFtwNyg+JyxaQu6ogWu48z6Nw1Zkbqo9EbcDEnQDh3GLst+KzPPtNAq4A6wI0XrAijwGVgXd3cD65B7wx/GkJOa3HVZkEe4smBjkPzGqq/MaaATuR0KDwGnglFH9HuRMBvYCe4iv/rVGtTnsLGUA4DWwJBbHfc4OIFlQ03ArvtRV3AIsj9WIWSXZEty5kOd+z0IBWGpU38aCJcmNaitw4T/Fwf1fiIpDmarYiowF3jD89suLj8Bio9pfakCesny6NzG+QvEeL/45a1DZ+fUETbgjOC/6cMVJpnguA95EK7AW91bl0IPbcq15uHOvcKPaAiwHsv7pdAErjOrLvLwVbTGj2gksBK5HwjeBhUa1oxLOqmFFGq3IByvyyYqsq5bnL6dNN9/YxSObAAAAAElFTkSuQmCC
        </xsl:variable>

        <xsl:variable name="validation_table_vars_raw">
            <var name="validation_rulewarning" value="iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABPklEQVQ4jY3SwUoVURwG8N+9XO6pFiHBCG0jonBAMBWsjVt3FbTpBXyBIMRnCB/EF3DnUlpFcQQRn8BDiCHiqFxczLkwjTM3P5jNd77v/33nzJ8ZSDGsphjezdIMZphf4wdGWCvK6veDB6QYxjjAUqYiVoqyumprhz0FvjbMUGL7QQ1SDC9wiDGOMv0KEywWZXXU1Hc1+I5HuMZCUVYLuMgDd2Y2SDGsY79BPc6DbhphG0VZ7d0bkGIYql99uTHgOa5w1uBivsqkfYUPLTPM5a+JEl/+aZDTf+XDJt7jEj9b/AneFGV1O23wqcMMH/G5g385bTFMMcBWh4h6C8c9Z99SDMNBx8tPca3+CxOc42mHZmOEzZ6EMXZx22OGzUGK4Q+e9Qj+h4sR3qpXdT4nPcnpo5Z4ot6JS/zFKY7vAJK/TOOqaXmrAAAAAElFTkSuQmCC"/>
            <var name="validation_ruleerror" value="iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAx0lEQVQ4ja2ToQ7CMBCGv6CmCAKBIgRJkIQgkBNIJALBSy7TPAEPgCKoSVTlj7klR9dljNGkSXvt/+X+uxbcEGSCQhBaZiHISA0TlwJ1zLIB6SFuQn4Qf0LMlz94Cs6Cl4sFwUVwj+4W2KEPHi2znUGC4GCxfXQ3pACVYG2CrSC39VLw+AZQQ1auyIuEWIIwSvYUxsDM7afApK3/cQbe87zOxNWk08Ip8uxrkqcAcRtvgk3kubIMrqk2DntIg5/yXz5TBOn1nd9HMnI+X86dsAAAAABJRU5ErkJggg=="/>
        </xsl:variable>

        <xsl:variable name="validation_table_vars" select="document('')//xsl:variable [@name='validation_table_vars_raw']/var" />
        <div class="no-print">
            <xsl:choose>
                <xsl:when test="ext:UBLExtensions/ext:UBLExtension[./cbc:ID='MessageInfo']">
                    <xsl:choose>
                        <xsl:when test="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:ValidationInfo[./umz:IsValid='true']">
                            <header style="background-color:#dff0d8; border-bottom: solid 3px #d6e9c6;display: flex; justify-content: space-between; padding: 0 13px; max-height: 60px;">
                                <div style="display: flex; justify-content: flex-start; align-items: center;">
                                    <img src="data:image/png;base64, {$banner_validation_approved-32}"
                                    style="width: 32px; height: 32px; margin-right: 1em;"/>
                                    <p style="color:#3c763d;font:14px verdana,Helvetica,sans-serif;">Skjalið stenst sannprófun</p>
                                </div>
                                <xsl:choose>
                                    <xsl:when test="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentUrl !=''">
                                        <xsl:choose>
                                            <xsl:when test="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransformationType = 'Transformed'">
                                                <div style="display: flex; justify-content: flex-end; align-items: center;">
                                                    <div style="display: flex; justify-content: flex-end; flex-direction: column; margin-right: 1em;">
                                                        <h2 style="text-align: right; margin: 0; margin-bottom: 5px; font:15px verdana,Helvetica,sans-serif; color: #000; font-weight: bold;">
                                                    Transformed document ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransactionProfile"/> )
                                                        </h2>
                                                        <p style="text-align: right; margin: 0; font:12px verdana,Helvetica,sans-serif; color: #000;">
                                                    It was transformed from original ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentTransactionProfile"/> )
                                                        </p>
                                                    </div>
                                                    <xsl:variable name="OtherDocumentUrl" select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentUrl" />
                                                    <a href="{$OtherDocumentUrl}" style="background: #000; color: #fff; padding: 5px 9px; border-radius: 4px; text-decoration: none; font:13px verdana,Helvetica,sans-serif;">
                                                    View original
                                                    </a>
                                                </div>
                                            </xsl:when>
                                            <xsl:when test="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransformationType = 'Original'">
                                                <div style="display: flex; justify-content: flex-end; align-items: center;">
                                                    <div style="display: flex; justify-content: flex-end; flex-direction: column; margin-right: 1em;">
                                                        <h2 style="text-align: right; margin: 0; margin-bottom: 5px; font:15px verdana,Helvetica,sans-serif; color: #000; font-weight: bold;">
                                                    Original document ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransactionProfile"/> )
                                                        </h2>
                                                        <p style="text-align: right; margin: 0; font:12px verdana,Helvetica,sans-serif; color: #000;">
                                                    It was transformed to ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentTransactionProfile"/> )
                                                        </p>
                                                    </div>
                                                    <xsl:variable name="OtherDocumentUrl" select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentUrl" />
                                                    <a href="{$OtherDocumentUrl}" style="background: #000; color: #fff;  padding: 5px 9px; border-radius: 4px; text-decoration: none; font:13px verdana,Helvetica,sans-serif;">
                                                    View transformed
                                                    </a>
                                                </div>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <div style="display: flex; justify-content: flex-end; align-items: center;">
                                            <h2 style="text-align: right; margin: 0; font:15px verdana,Helvetica,sans-serif; color: #000; font-weight: bold;">
                                                    Document ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransactionProfile"/> )
                                            </h2>
                                        </div>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </header>
                        </xsl:when>
                        <xsl:when test="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:ValidationInfo[./umz:IsValid='false']">
                            <header style="background-color:#f2dede; display: flex;justify-content: space-between; padding: 0 13px; max-height: 60px;">
                                <div style="display: flex; justify-content: flex-start; align-items: center;">
                                    <img src="data:image/png;base64, {$banner_validation_rejected-32}"
                                    style="width: 32px; height: 32px; margin-right: 1em;"/>
                                    <p style="color:#3c763d;font:14px verdana,Helvetica,sans-serif;">Skjalið uppfyllir ekki tækniforskrift</p>
                                </div>
                                <xsl:choose>
                                    <xsl:when test="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentUrl !=''">
                                        <xsl:choose>
                                            <xsl:when test="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransformationType = 'Transformed'">
                                                <div style="display: flex; justify-content: flex-end; align-items: center;">
                                                    <div style="display: flex; justify-content: flex-end; flex-direction: column; margin-right: 1em;">
                                                        <h2 style="text-align: right; margin: 0; margin-bottom: 5px; font:15px verdana,Helvetica,sans-serif; color: #000; font-weight: bold;">
                                                    Transformed document ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransactionProfile"/> )
                                                        </h2>
                                                        <p style="text-align: right; margin: 0; font:12px verdana,Helvetica,sans-serif; color: #000;">
                                                    It was transformed from original ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentTransactionProfile"/> )
                                                        </p>
                                                    </div>
                                                    <xsl:variable name="OtherDocumentUrl" select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentUrl" />
                                                    <a href="{$OtherDocumentUrl}" style="background: #000; color: #fff; padding: 5px 9px; border-radius: 4px; text-decoration: none; font:13px verdana,Helvetica,sans-serif;">
                                                    View original
                                                    </a>
                                                </div>
                                            </xsl:when>
                                            <xsl:when test="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransformationType = 'Original'">
                                                <div style="display: flex; justify-content: flex-end; align-items: center;">
                                                    <div style="display: flex; justify-content: flex-end; flex-direction: column; margin-right: 1em;">
                                                       <h2 style="text-align: right; margin: 0; margin-bottom: 5px; font:15px verdana,Helvetica,sans-serif; color: #000; font-weight: bold;">
                                                    Original document ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransactionProfile"/> )
                                                        </h2>
                                                        <p style="text-align: right; margin: 0; font:12px verdana,Helvetica,sans-serif; color: #000;">
                                                    It was transformed to ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentTransactionProfile"/> )
                                                        </p>
                                                    </div>
                                                    <xsl:variable name="OtherDocumentUrl" select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:OtherDocumentUrl" />
                                                    <a href="{$OtherDocumentUrl}" style="background: #000; color: #fff; padding: 5px 9px; border-radius: 4px; text-decoration: none; font:13px verdana,Helvetica,sans-serif;">
                                                    View transformed
                                                    </a>
                                                </div>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <div style="display: flex; justify-content: flex-end; align-items: center;">
                                            <h2 style="text-align: right; margin: 0; font:15px verdana,Helvetica,sans-serif; color: #000; font-weight: bold;">
                                                    Document ( <xsl:value-of select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:TransformationInfo/umz:DocumentTransactionProfile"/> )
                                            </h2>
                                        </div>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </header>
                            <div style="background-color:#fff5f5;padding:15px;">
                                <table>
                                    <xsl:for-each select="ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/umz:MessageInfoExtension/umz:ValidationInfo/umz:Entries/umz:MessageValidationEntry">
                                        <tr>
                                            <td>
                                                <!--<img src="/images/messagestatus/{umz:StatusImageTag}.png" alt="{umz:StatusImageDescription}" />-->
                                                <xsl:variable name="statusImageTag">
                                                    <xsl:value-of select="umz:StatusImageTag" />
                                                </xsl:variable>
                                                <xsl:variable name="validationIcon" select="$validation_table_vars[@name = $statusImageTag]/@value" />
                                                <img src="data:image/png;base64, {$validationIcon}" alt="{umz:StatusImageDescription}" />
                                            </td>
                                            <td colspan="2" style="text-align:left;">
                                                <strong>
                                                    <xsl:value-of select="umz:FriendlyMessage"/>
                                                </strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="text-align:left;vertical-align:top;">
                                                <small>
                                                    <xsl:value-of select="umz:ReferenceKey"/>
                                                </small>
                                            </td>
                                            <td style="text-align:left;vertical-align:top;">
                                                <small>
                                                    <xsl:value-of select="umz:DetailMessage"/>
                                                </small>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </table>
                            </div>
                            <div style="background-color:#f2dede;border-bottom: solid 3px #ebccd1;">
                                <span></span>
                            </div>
                        </xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>
</xsl:stylesheet>
