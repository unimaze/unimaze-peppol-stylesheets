<?xml version="1.0" encoding="utf-8"?>
<!--
******************************************************************************************************************

        PEPPOL Instance Documentation title= PEPPOL-BIS-EN-UBL-3.0-CommonTemplates.xml publisher= "Unimaze Software" Creator= "Unimaze SoftwareW created= 2019-02-12 conformsTo= UBL-Invoice-2.1.xsd description= "Common templates for displaying BISENUBL-3.0 - PEPPOL BIS, European Norm, version 3.0 (Invoice and Credit note)"

		Derived from work by SFTI, Sweden anbd OIOUBL, Denmark. For more information, see www.unimaze.com or email info at unimaze dot com

        Copyright (C) 2008-2019 Unimaze Software (www.unimaze.com)
        info[at]unimaze[dot]com

        Licensed under the Apache License, Version 2.0 (the "License");
        you may not use this file except in compliance with the License.
        You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an "AS IS" BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.

******************************************************************************************************************
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fcn="urn:sfti:se:xsl:functions"
    xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:n2="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
    xmlns:cdl="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
    xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2"
    xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2"
    exclude-result-prefixes="n1 n2 cac cdl cbc ccts fcn sdt udt">
    <xsl:include href="../common/user_config.xsl" />
    <xsl:variable name="moduleDocBT_en" select="document('Headlines-BT_en.xml')" />
    <xsl:variable name="moduleDocBT" select="document(concat('Headlines-BT_', $languageCode, '.xml'))" />
    <xsl:variable name="moduleDocUMZBT_en" select="document('Headlines-UMZ-BT_en.xml')" />
    <xsl:variable name="moduleDocUMZBT" select="document(concat('Headlines-UMZ-BT_', $languageCode, '.xml'))" />
    <xsl:variable name="invoiceBaseType" select="document(concat('UBLInvoiceBaseType_',$languageCode, '.xml'))" />
    <xsl:variable name="UNCL1001" select="document(concat('../common/UNCL1001_', $languageCode, '.xml'))" />
    <xsl:variable name="UNCL4343OpSubset" select="document(concat('../common/UNCL4343OpSubset_', $languageCode, '.xml'))" />
    <xsl:variable name="UNCL4461" select="document(concat('../common/UNCL4461_', $languageCode, '.xml'))" />
    <xsl:variable name="UNCL7161" select="document(concat('../common/UNCL7161_', $languageCode, '.xml'))" />
    <xsl:variable name="UNCL5189" select="document(concat('../common/UNCL5189_', $languageCode, '.xml'))" />
    <xsl:variable name="OPStatusReason" select="document(concat('../common/OPStatusReason_', $languageCode, '.xml'))" />
    <xsl:variable name="OPStatusAction" select="document(concat('../common/OPStatusAction_', $languageCode, '.xml'))" />
    <xsl:variable name="UBLDescriptionCode" select="document(concat('../common/UBLPeriodDescriptionCode_', $languageCode, '.xml'))" />
    <xsl:variable name="UBLTaxCategoryCode" select="document(concat('../common/UBLTaxCategoryCode_', $languageCode, '.xml'))" />
    <xsl:variable name="UBLClassificationCode" select="document(concat('../common/UBLClassificationCode_', $languageCode, '.xml'))" />
    <xsl:variable name="UNECE" select="document(concat('../common/UNECE_', $languageCode, '.xml'))" />
    <xsl:variable name="UNCL1001_en" select="document('../common/UNCL1001_en.xml')" />
    <xsl:variable name="UNCL4343OpSubset_en" select="document('../common/UNCL4343OpSubset_en.xml')" />
    <xsl:variable name="UNCL4461_en" select="document('../common/UNCL4461_en.xml')" />
    <xsl:variable name="UNCL7161_en" select="document('../common/UNCL7161_en.xml')" />
    <xsl:variable name="UNCL5189_en" select="document('../common/UNCL5189_en.xml')" />
    <xsl:variable name="OPStatusReason_en" select="document('../common/OPStatusReason_en.xml')" />
    <xsl:variable name="OPStatusAction_en" select="document('../common/OPStatusAction_en.xml')" />
    <xsl:variable name="UBLDescriptionCode_en" select="document('../common/UBLPeriodDescriptionCode_en.xml')" />
    <xsl:variable name="UBLTaxCategoryCode_en" select="document('../common/UBLTaxCategoryCode_en.xml')" />
    <xsl:variable name="UBLClassificationCode_en" select="document('../common/UBLClassificationCode_en.xml')" />
    <xsl:variable name="invoiceBaseType_en" select="document('UBLInvoiceBaseType_en.xml')" />
    <xsl:variable name="UNECE_en" select="document('../common/UNECE_en.xml')" />
    <xsl:variable name="table_item_ID" select="cbc:ID" />
    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>
    <!-- A function which will choose first DisplayName, then Business Term for the installed language for every xpath -->
    <xsl:template name="LabelName">
        <xsl:param name="BT-ID" />
        <!-- BT inparameter -->
        <xsl:param name="Colon-Suffix" />
        <!-- true/false whether the a colon will be added after the business term name-->
        <xsl:choose>
            <xsl:when test="$moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID]/DisplayName">
                <xsl:value-of select="$moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID]/DisplayName" />
                <xsl:choose>
                    <xsl:when
                        test="$Colon-Suffix ='true' and $moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID]/DisplayName!=''">:&#8201;</xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID]/TermName">
                        <xsl:value-of select="$moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID]/TermName" />
                        <xsl:choose>
                            <xsl:when test="$Colon-Suffix ='true'">:&#8201;</xsl:when>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- UNIMAZE HEADLINES TEMPLATE  -->
    <xsl:template name="UMZLabelName">
        <xsl:param name="BT-ID" />
        <!-- BT inparameter -->
        <xsl:param name="Colon-Suffix" />
        <!-- true/false whether the a colon will be added after the business term name-->
        <xsl:choose>
            <xsl:when test="$moduleDocUMZBT/SemanticModel/BusinessTerm[@id=$BT-ID]/DisplayName">
                <xsl:value-of select="$moduleDocUMZBT/SemanticModel/BusinessTerm[@id=$BT-ID]/DisplayName" />
                <xsl:choose>
                    <xsl:when
                        test="$Colon-Suffix ='true' and $moduleDocUMZBT/SemanticModel/BusinessTerm[@id=$BT-ID]/DisplayName!=''">:&#8201;</xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$moduleDocUMZBT/SemanticModel/BusinessTerm[@id=$BT-ID]/TermName">
                        <xsl:value-of select="$moduleDocUMZBT/SemanticModel/BusinessTerm[@id=$BT-ID]/TermName" />
                        <xsl:choose>
                            <xsl:when test="$Colon-Suffix ='true'">:&#8201;</xsl:when>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--A function to display currencies locale with spaces as thousand delimiter-->
    <xsl:template name="Currency">
        <xsl:param name="currencyvalue" />
        <xsl:param name="country" />
        <xsl:variable name="integerPart" select="substring-before($currencyvalue, '.')" />
        <xsl:variable name="decimalAddition" select="'00'" />
        <xsl:variable name="transformedIntegers_period" select="translate(format-number(number($integerPart), '#,###'), ',', '.' )" />
        <xsl:variable name="transformedIntegers_comma" select="translate(format-number(number($integerPart), '#,###'), ',', ',' )" />
        <xsl:variable name="transformedIntegers_space" select="translate(format-number(number($integerPart), '#,###'), ',', ' ' )" />
        <xsl:variable name="transformedCurrencyValue_period" select="translate(format-number(number($currencyvalue), '#,###'), ',', '.' )" />
        <xsl:variable name="transformedCurrencyValue_comma" select="translate(format-number(number($currencyvalue), '#,###'), ',', ',' )" />
        <xsl:variable name="transformedCurrencyValue_space" select="translate(format-number(number($currencyvalue), '#,###'), ',', ' ' )" />
        <xsl:choose>
            <xsl:when test="$integerPart != ''">
                <xsl:variable name="decimalPart" select="substring-after($currencyvalue, '.')" />
                <xsl:choose>
                    <xsl:when test="(($transformedIntegers_period !='NaN') and ($transformedIntegers_comma !='NaN') and ($transformedIntegers_space !='NaN'))">
                        <xsl:choose>
                            <xsl:when test="$country = 'is'">
                                <xsl:choose>
                                    <xsl:when test="($decimalPart != 0) or ($decimalPart != '0')">
                                        <xsl:value-of select="concat($transformedIntegers_period,',', $decimalPart)" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat($transformedIntegers_period,',', $decimalAddition)" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="$country = 'en'">
                                <xsl:choose>
                                    <xsl:when test="($decimalPart != 0) or ($decimalPart != '0')">
                                        <xsl:value-of select="concat($transformedIntegers_comma,'.', $decimalPart)" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat($transformedIntegers_comma,'.', $decimalAddition)" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="$country = 'se'">
                                <xsl:choose>
                                    <xsl:when test="($decimalPart != 0) or ($decimalPart != '0')">
                                        <xsl:value-of select="concat($transformedIntegers_space,',', $decimalPart)" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat($transformedIntegers_space,',', $decimalAddition)" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="($decimalPart != 0) or ($decimalPart != '0')">
                                        <xsl:value-of select="concat($transformedIntegers_space,',', $decimalPart)" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat($transformedIntegers_space,',', $decimalAddition)" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$country = 'is'">
                                <xsl:value-of select="concat($transformedCurrencyValue_period, ',', $decimalAddition)" />
                            </xsl:when>
                            <xsl:when test="$country = 'en'">
                                <xsl:value-of select="concat($transformedCurrencyValue_comma, '.', $decimalAddition)" />
                            </xsl:when>
                            <xsl:when test="$country = 'se'">
                                <xsl:value-of select="concat($transformedCurrencyValue_space, ',', $decimalAddition)" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat($transformedCurrencyValue_space, ',', $decimalAddition)" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="(($transformedIntegers_period !='NaN') and ($transformedIntegers_comma !='NaN') and ($transformedIntegers_space !='NaN'))">
                        <xsl:choose>
                            <xsl:when test="$country = 'is'">
                                <xsl:value-of select="$transformedIntegers_period" />
                            </xsl:when>
                            <xsl:when test="$country = 'en'">
                                <xsl:value-of select="$transformedIntegers_comma" />
                            </xsl:when>
                            <xsl:when test="$country = 'se'">
                                <xsl:value-of select="$transformedIntegers_space" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$transformedIntegers_space" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$country = 'is'">
                                <xsl:value-of select="concat($transformedCurrencyValue_period, ',',$decimalAddition)" />
                            </xsl:when>
                            <xsl:when test="$country = 'en'">
                                <xsl:value-of select="concat($transformedCurrencyValue_comma, '.',$decimalAddition)" />
                            </xsl:when>
                            <xsl:when test="$country = 'se'">
                                <xsl:value-of select="concat($transformedCurrencyValue_space, ',',$decimalAddition)" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat($transformedCurrencyValue_space, ',',$decimalAddition)" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="getGenericCode">
        <xsl:param name="documentName" />
        <xsl:param name="documentName_en" />
        <xsl:param name="documentCode" />
        <xsl:choose>
            <xsl:when
                test="$documentName/cdl:CodeList/cdl:SimpleCodeList/cdl:Row/cdl:Value/cdl:SimpleValue[../@ColumnRef='name' and ../../cdl:Value[@ColumnRef='code']/cdl:SimpleValue=$documentCode]">
                <xsl:value-of
                    select="$documentName/cdl:CodeList/cdl:SimpleCodeList/cdl:Row/cdl:Value/cdl:SimpleValue[../@ColumnRef='name' and ../../cdl:Value[@ColumnRef='code']/cdl:SimpleValue=$documentCode]" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when
                        test="$documentName_en/cdl:CodeList/cdl:SimpleCodeList/cdl:Row/cdl:Value/cdl:SimpleValue[../@ColumnRef='name' and ../../cdl:Value[@ColumnRef='code']/cdl:SimpleValue=$documentCode]">
                        <xsl:value-of
                            select="$documentName_en/cdl:CodeList/cdl:SimpleCodeList/cdl:Row/cdl:Value/cdl:SimpleValue[../@ColumnRef='name' and ../../cdl:Value[@ColumnRef='code']/cdl:SimpleValue=$documentCode]" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$documentCode" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--Function to pick the Base Type codes for document header-->
    <xsl:template name="DocumentHeader">
        <xsl:param name="DocumentCode" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$invoiceBaseType" />
            <xsl:with-param name="documentName_en" select="$invoiceBaseType_en" />
            <xsl:with-param name="documentCode" select="$DocumentCode" />
        </xsl:call-template>
    </xsl:template>
    <!--Function to pick the UNCL1001 codes for document header-->
    <xsl:template name="DocumentCode">
        <xsl:param name="DCode" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$UNCL1001" />
            <xsl:with-param name="documentName_en" select="$UNCL1001_en" />
            <xsl:with-param name="documentCode" select="$DCode" />
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="UBLDescriptionCode">
        <xsl:param name="Code" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$UBLDescriptionCode" />
            <xsl:with-param name="documentName_en" select="$UBLDescriptionCode_en" />
            <xsl:with-param name="documentCode" select="$Code" />
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="UBLTaxCategoryCode">
        <xsl:param name="Code" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$UBLTaxCategoryCode" />
            <xsl:with-param name="documentName_en" select="$UBLTaxCategoryCode_en" />
            <xsl:with-param name="documentCode" select="$Code" />
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="UBLClassificationCode">
        <xsl:param name="Code" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$UBLClassificationCode" />
            <xsl:with-param name="documentName_en" select="$UBLClassificationCode_en" />
            <xsl:with-param name="documentCode" select="$Code" />
        </xsl:call-template>
    </xsl:template>
    <!--Function to pick the Status Clarification Reason code-->
    <xsl:template name="StatusClarificationReason">
        <xsl:param name="Code" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$OPStatusReason" />
            <xsl:with-param name="documentName_en" select="$OPStatusReason_en" />
            <xsl:with-param name="documentCode" select="$Code" />
        </xsl:call-template>
    </xsl:template>
    <!--Function to pick the Status Clarification Reason code-->
    <xsl:template name="StatusClarificationAction">
        <xsl:param name="Code" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$OPStatusAction" />
            <xsl:with-param name="documentName_en" select="$OPStatusAction_en" />
            <xsl:with-param name="documentCode" select="$Code" />
        </xsl:call-template>
    </xsl:template>
    <!--Function to pick the AllowanceReasonCodes-->
    <xsl:template name="AllowanceReasonCode">
        <xsl:param name="AllowanceCode" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$UNCL5189" />
            <xsl:with-param name="documentName_en" select="$UNCL5189_en" />
            <xsl:with-param name="documentCode" select="$AllowanceCode" />
        </xsl:call-template>
    </xsl:template>
    <!--Function to pick the ChargeReasonCodes-->
    <xsl:template name="ChargeReasonCode">
        <xsl:param name="ChargeCode" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$UNCL7161" />
            <xsl:with-param name="documentName_en" select="$UNCL7161_en" />
            <xsl:with-param name="documentCode" select="$ChargeCode" />
        </xsl:call-template>
    </xsl:template>
    <!--Function to pick up ApplicationResponseCode code-->
    <xsl:template name="ApplicationResponseCode">
        <xsl:param name="ResponseCode" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$UNCL4343OpSubset" />
            <xsl:with-param name="documentName_en" select="$UNCL4343OpSubset_en" />
            <xsl:with-param name="documentCode" select="$ResponseCode" />
        </xsl:call-template>
    </xsl:template>
    <!--Function to pick up payment means code-->
    <xsl:template name="PaymentMeansCode">
        <xsl:param name="PaymentCode" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$UNCL4461" />
            <xsl:with-param name="documentName_en" select="$UNCL4461_en" />
            <xsl:with-param name="documentCode" select="$PaymentCode" />
        </xsl:call-template>
    </xsl:template>
    <!--Function to pick the UNECE codes-->
    <xsl:template name="UNECECode">
        <xsl:param name="Code" />
        <xsl:call-template name="getGenericCode">
            <xsl:with-param name="documentName" select="$UNECE" />
            <xsl:with-param name="documentName_en" select="$UNECE_en" />
            <xsl:with-param name="documentCode" select="$Code" />
        </xsl:call-template>
    </xsl:template>
    <!--Function to format date to locale format-->
    <xsl:template name="formatDate">
        <xsl:param name="dateTime" />
        <xsl:param name="country" />
        <xsl:variable name="year" select="substring-before($dateTime, '-')" />
        <xsl:variable name="month" select="substring-before(substring-after($dateTime, '-'), '-')" />
        <xsl:variable name="day" select="substring-after(substring-after($dateTime, '-'), '-')" />
        <xsl:choose>
            <xsl:when test="($year !='') or ($month !='') or ($day !='')">
                <xsl:choose>
                    <xsl:when test="$country = 'is'">
                        <xsl:value-of select="concat($day, '.', $month, '.', $year)" />
                    </xsl:when>
                    <xsl:when test="$country = 'en'">
                        <xsl:value-of select="concat( $month, '/', $day, '/', $year)" />
                    </xsl:when>
                    <xsl:when test="$country = 'se'">
                        <xsl:value-of select="concat($year, '-', $month, '-' , $day)" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($day, '.', $month, '.', $year)" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$dateTime" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--Function to format time-->
    <xsl:template name="formatTime">
        <xsl:param name="time" />
        <xsl:variable name="hours" select="substring-before($time, ':')" />
        <xsl:variable name="minutes" select="substring-before(substring-after($time, ':'), ':')" />
        <xsl:variable name="seconds" select="substring-after(substring-after(substring-before($time, '.'), ':'), ':')" />
        <xsl:choose>
            <xsl:when test="($hours !='') or ($minutes !='') or ($seconds !='')">
                <xsl:value-of select="concat($hours, ':', $minutes, ':', $seconds)" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$time" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Function to format numbers -->
    <xsl:template name="NumberFormat">
        <xsl:param name="value" />
        <xsl:param name="formatToDecimal" />
        <xsl:param name="country" />
        <xsl:variable name="integerPart" select="substring-before($value, '.')" />
        <xsl:variable name="decimalPart" select="substring-after($value, '.')" />
        <xsl:choose>
            <xsl:when test="($formatToDecimal = 'false')  or ($formatToDecimal = '')">
                <xsl:choose>
                    <xsl:when test="$integerPart != ''">
                        <xsl:variable name="cutedDecimalPart" select="substring($decimalPart, 1, 1)" />
                        <xsl:choose>
                            <xsl:when test="($cutedDecimalPart != '0') or ($cutedDecimalPart != 0)">
                                <xsl:value-of select="concat($integerPart , $cutedDecimalPart )" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$integerPart" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$value" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$formatToDecimal = 'true'">
                <xsl:choose>
                    <xsl:when test="$integerPart != ''">
                        <xsl:variable name="cutedDecimalPart" select="substring($decimalPart, 1, 2)" />
                        <xsl:choose>
                            <xsl:when test="($cutedDecimalPart = '00') or ($cutedDecimalPart = '0') or ($cutedDecimalPart = 0) or ($cutedDecimalPart = 00)">
                                <xsl:value-of select="$integerPart" />
                            </xsl:when>
                            <xsl:otherwise>
                             <xsl:choose>
                                    <xsl:when test="$country = 'en'">
                                        <xsl:value-of select="concat($integerPart, '.' , $cutedDecimalPart )" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat($integerPart, ',' , $cutedDecimalPart )" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$value" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$value" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Function Replace -->
    <xsl:template name="replace">
        <xsl:param name="string" />
        <xsl:choose>
            <xsl:when test="contains($string,'&#10;')">
                <xsl:value-of select="substring-before($string,'&#10;')" />
                <br />
                <xsl:call-template name="replace">
                    <xsl:with-param name="string" select="substring-after($string,'&#10;')" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="cbc:Note">
        <xsl:call-template name="replace">
            <xsl:with-param name="string" select="." />
        </xsl:call-template>
    </xsl:template>
    <!--Party templates from here:-->
    <xsl:template match=" cac:AccountingSupplierParty">
        <xsl:call-template name="SellerParty" />
    </xsl:template>
    <xsl:template match=" cac:AccountingCustomerParty">
        <xsl:call-template name="BuyerParty" />
    </xsl:template>
    <!--SELLER PARTY STARTS HERE-->
    <!--SELLER STARTS HERE-->
    <xsl:template name="Seller">
        <b>
            <xsl:choose>
                <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PartyName !=''">
                    <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyName" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                </xsl:otherwise>
            </xsl:choose>
        </b>
        <br/>
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName !=''">
            <span class="UBLStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-35'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName" />
            </span>&#8201;
        </xsl:if>
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber !=''">
            <span class="UBLBuildingNumber">
                <xsl:apply-templates
                    select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber" />
            </span>
        </xsl:if>
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-36'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates
                    select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:apply-templates
                    select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line" />
            </span>
        </xsl:if>
        <xsl:if
            test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName !=''">
            <br />
            <span class="UBLCityName">
                <xsl:choose>
                    <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-38'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone" />&#8201;
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-37'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName" />,
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-37'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName" />,
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:if>
        <xsl:if
            test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
            <xsl:choose>
                <xsl:when
                    test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-39'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />, 
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-40'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-39'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />, 
                    </xsl:if>
                    <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-40'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode" />
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <br />
         <xsl:choose>
                <xsl:when test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID !=''">
                    <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    <xsl:template name="AdditionalInfoAccountingSupplierPartyNameTitle">
        <xsl:choose>
            <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress != ''" >
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-020'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-026'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="AdditionalInfoAccountingCustomerPartyNameTitle">
        <xsl:choose>
            <xsl:when test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress != ''" >
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-020'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-026'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="SellerPartyName">
        <xsl:choose>
            <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PartyName !=''">
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyName" />
            </xsl:when>
            <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name !=''">
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="SellerAdditionalInfo">
        <small>
            <b>
                <xsl:call-template name="AdditionalInfoAccountingSupplierPartyNameTitle" />
            </b>
        </small>
        <br/>
        <xsl:call-template name="SellerPartyName" />
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber !=''">
            <span class="UBLBuildingNumber">
                <xsl:apply-templates
                    select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber" />
            </span>
        </xsl:if>
        <xsl:call-template name="SellerPostalAddress" />
        <xsl:call-template name="SellerID" />
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact !=''">
            <div class="box_with_top_margin">
                <small>
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BG-6'"/>
                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                        </xsl:call-template>
                    </b>
                </small>
            </div>
            <xsl:call-template name="SellerContact" />
        </xsl:if>
        <xsl:call-template name="SellerPostalID" />
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID">
            <div class="box_with_top_margin">
                <small>
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-34'"/>
                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                        </xsl:call-template>
                    </b>
                </small>
            </div>
            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID"/>
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID !='' ">
            [<xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID"/>]
            </xsl:if>
            <br/>
        </xsl:if>
        <div class="box_with_top_margin">
            <xsl:call-template name="SellerPartyTaxScheme" />
        </div>
        <div class="box_with_top_margin">
            <xsl:call-template name="SellerPartyLegalEntity" />
        </div>
        <xsl:if test="cac:TaxRepresentativeParty !=''">
            <small>
                <b>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BG-11'"/>
                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                    </xsl:call-template>
                </b>
            </small>
            <br/>
            <xsl:apply-templates select="cac:TaxRepresentativeParty"/>
        </xsl:if>
    </xsl:template>

    <!--Party legal registration: -->
    <xsl:template name="SellerPartyLegalEntity">
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity">
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID">
                <p>
                    <small>
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-47'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                    </small>
                </p>     
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID" />]
                </xsl:if>
                <br/>
            </xsl:if>
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                <p class="box_with_top_margin">
                    <small>
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-27'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                    </small>
                </p> 
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                <br/>
            </xsl:if>
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm != ''">
                    <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm" />
                <br/>
            </xsl:if>
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress !=''">
                <xsl:choose>
                        <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !='' and cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />,&#8201;
                            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !=''">
                                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />
                            </xsl:if>
                            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                <br/>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template name="SellerPartyTaxScheme">
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme">
            <p>
                <small>
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-63'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                    </b>
                </small>
            </p>
            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID" />]
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template name="SellerParty">
        <xsl:call-template name="LabelName">
            <xsl:with-param name="BT-ID" select="'BT-27'" />
            <xsl:with-param name="Colon-Suffix" select="'true'" />
        </xsl:call-template>
        <b>
            <xsl:choose>
                <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PartyName !=''">
                    <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyName" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                </xsl:otherwise>
            </xsl:choose>
        </b>
        <br />
        <b>
            <xsl:call-template name="LabelName">
                <xsl:with-param name="BT-ID" select="'BG-5'" />
                <xsl:with-param name="Colon-Suffix" select="'false'" />
            </xsl:call-template>
        </b>
        <xsl:call-template name="SellerPostalAddress" />
        <xsl:for-each select="cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification">
            <xsl:if test="cbc:ID">
                <br />
                <small>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-29'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cbc:ID" />
                    <xsl:if test="cbc:ID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cbc:ID/@schemeID" />]
                    </xsl:if>
                    &#8201;
                </small>
            </xsl:if>
        </xsl:for-each>
        <!--Party legal registration: -->
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity">
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID">
                <br />
                <small>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-30'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                    <xsl:if
                        test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID" />]
                    </xsl:if>
                </small>
            </xsl:if>
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                <br />
                <small>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-27'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                </small>
            </xsl:if>
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm != ''">
                <small>
                    <br />
                    <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm" />
                </small>
            </xsl:if>
            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress !=''">
                <br />
                <small>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-33'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:choose>
                        <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !='' and

							cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                            <xsl:apply-templates
                                select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />,&#8201;
                            <xsl:apply-templates
                                select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if
                                test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !=''">
                                <xsl:apply-templates
                                    select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />
                            </xsl:if>
                            <xsl:if
                                test="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                                <xsl:apply-templates
                                    select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </small>
            </xsl:if>
        </xsl:if>
        <!--Party VAT registration: -->
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme">
            <small>
                <xsl:for-each select="cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme">
                    <br />
                    <xsl:choose>
                        <xsl:when test="cac:TaxScheme/cbc:ID = 'VAT'">
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-31'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                            <xsl:apply-templates select="cbc:CompanyID" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-32'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                            <xsl:apply-templates select="cbc:CompanyID" />
                            [<xsl:value-of select="cac:TaxScheme/cbc:ID" />]
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="cbc:ExemptionReason">
                        <br />&#8201;
                        <xsl:apply-templates select="cbc:ExemptionReason" />
                    </xsl:if>
                </xsl:for-each>
            </small>
        </xsl:if>
    </xsl:template>
    <xsl:template name="SellerPostalID">
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:ID !=''">
            <br/>
                <b>
                    <xsl:call-template name="UMZLabelName">
                        <xsl:with-param name="BT-ID" select="'UMZ-BT-016'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
            <br/>
            <span class="UBLPostalID">
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:ID" />
            </span>
        </xsl:if>
    </xsl:template>
    <xsl:template name="SellerID">
        <div class="box_with_top_margin">
            <small>
                <b>
                    <xsl:call-template name="UMZLabelName">
                        <xsl:with-param name="BT-ID" select="'UMZ-BT-017'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
            </small>
        </div>
        <span class="UBLID">
            <xsl:choose>
                <xsl:when test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID !=''">
                    <xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template name="SellerPostalAddress">
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName !=''">
            <br />
            <span class="UBLStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-35'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName" />
            </span>&#8201;
        </xsl:if>
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-36'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates
                    select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-162'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates
                    select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line" />
            </span>
        </xsl:if>
        <xsl:if
            test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName !=''">
            <br />
            <span class="UBLCityName">
                <xsl:choose>
                    <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-38'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone" />&#8201;
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-37'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName" />,&#8201;
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-37'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName" />,&#8201;
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:if>
        <xsl:if
            test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
            <xsl:choose>
                <xsl:when
                    test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-39'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />,&#8201;
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-40'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-39'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />
                    </xsl:if>
                    <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-40'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode" />
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template name="SellerContact">
        <xsl:param name="ShowLabel" />
        <xsl:if test="((cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name !='') and (cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name != cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name))">
            <span class="UBLName">
                <xsl:if test="$ShowLabel='true'">
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-41'"/>
                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                        </xsl:call-template>
                    </b>
                </xsl:if>
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name"/>
                <br/>
            </span>
        </xsl:if>
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone !=''">
            <span class="UBLTelephone">
                <xsl:if test="$ShowLabel='true'"> 
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-42'"/>
                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                        </xsl:call-template>
                    </b>
                </xsl:if> 
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone" />
            </span>
            <br/>
        </xsl:if>
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax !=''">
            <span class="UBLTelefax">
                <xsl:if test="$ShowLabel='true'"> 
                    <b>
                        <xsl:call-template name="UMZLabelName">
                            <xsl:with-param name="BT-ID" select="'UMZ-BT-001'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                    </b>
                </xsl:if> 
                <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax" />
            </span>
            <br/>
        </xsl:if>
        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail !=''">
            <span class="UBLElectronicMail">
                <xsl:if test="$ShowLabel='true'"> 
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-43'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                    </b>
                </xsl:if> 
                <xsl:apply-templates
                        select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail" />
            </span>
            <br/>
        </xsl:if>
    </xsl:template>
    <!-- /SELLER PARTY -->
    <!-- SELLER SUPPLIER PARTY STARTS HERE-->
    <xsl:template name="SellerSupplierPartyName">
        <xsl:choose>
            <xsl:when test="cac:SellerSupplierParty/cac:Party/cac:PartyName !=''">
                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PartyName" />
            </xsl:when>
            <xsl:when test="cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name !=''">
                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates
                        select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="SellerSupplierParty">
        <b>
            <xsl:call-template name="SellerSupplierPartyName" />
        </b>
        <p>
            <xsl:choose>
                <xsl:when test="cac:SellerSupplierParty/cac:Party/cbc:EndpointID !=''">
                    <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cbc:EndpointID" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates
                        select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                </xsl:otherwise>
            </xsl:choose>
        </p>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName !=''">
            <span class="UBLStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-35'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName" />
            </span>&#8201;
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber !=''">
            <span class="UBLBuildingNumber">
                <xsl:apply-templates
                    select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber" />
            </span>
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-36'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates
                    select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:apply-templates
                    select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line" />
            </span>
        </xsl:if>
        <xsl:if
            test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName !=''">
            <br />
            <span class="UBLCityName">
                <xsl:choose>
                    <xsl:when test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-38'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone" />&#8201;
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-37'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName" />,
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-37'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName" />,
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:if>
        <xsl:if
            test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
            <xsl:choose>
                <xsl:when
                    test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-39'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                        select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />,
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-40'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">,
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-39'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />,
                    </xsl:if>
                    <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-40'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode" />
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template name="SellerSupplierPostalAddress">
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber !=''">
            <span class="UBLBuildingNumber">
                <xsl:apply-templates
                    select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber" />
            </span>
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName !=''">
            <!-- <br /> -->
            <span class="UBLStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-35'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-36'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates
                    select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:apply-templates
                    select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line" />
            </span>
        </xsl:if>
        <xsl:if
            test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName !=''">
            <br />
            <span class="UBLCityName">
                <xsl:choose>
                    <xsl:when test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-38'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone" />&#8201;
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-37'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName" />,
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-37'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName" />,
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:if>
        <xsl:if
            test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
            <xsl:choose>
                <xsl:when
                    test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                    <br />
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-39'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                        select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />,
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-40'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country" />
                </xsl:when>
                <xsl:otherwise>
                    <!-- <br/> -->
                    <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-39'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />,
                    </xsl:if>
                    <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-40'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode" />
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template name="SellerSupplierContact">
        <xsl:if test="((cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name !='') and (cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name != cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name))">
            <p class="UBLName">
                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"/>
            </p>
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telephone !=''">
            <span class="UBLTelephone">
                <b class="seller_contact_label">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-42'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telephone" />
            </span>
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telefax !=''">
            <br />
            <span class="UBLTelefax">
                <b class="seller_contact_label">
                    <xsl:call-template name="UMZLabelName">
                        <xsl:with-param name="BT-ID" select="'UMZ-BT-001'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telefax" />
            </span>
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail !=''">
            <br />
            <span class="UBLElectronicMail">
                <b class="seller_contact_label">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-43'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
                <xsl:apply-templates
                        select="cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail" />
            </span>
        </xsl:if>
    </xsl:template>
    <xsl:template name="SellerSupplierPostalID">
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:ID !=''">
            <p>
                <b>
                    <xsl:call-template name="UMZLabelName">
                        <xsl:with-param name="BT-ID" select="'UMZ-BT-016'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
            </p>
            <span class="UBLPostalID">
                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:ID" />
            </span>
        </xsl:if>
    </xsl:template>
    <xsl:template name="SellerSupplierPartyLegalEntityID">
        <span class="UBLID">
            <xsl:choose>
                <xsl:when test="cac:SellerSupplierParty/cac:Party/cbc:EndpointID !=''">
                    <xsl:value-of select="cac:SellerSupplierParty/cac:Party/cbc:EndpointID" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template name="SellerSupplierPartyID">
        <xsl:choose>
            <xsl:when test="cac:SellerSupplierParty/cac:Party/cbc:EndpointID !=''">
                <xsl:value-of select="cac:SellerSupplierParty/cac:Party/cbc:EndpointID" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="AdditionalInfoSellerSupplierPartyNameTitle">
        <xsl:choose>
            <xsl:when test="cac:SellerSupplierParty/cac:Party/cac:PostalAddress != ''" >
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-020'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-026'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="SellerSupplierPartyAdditionalInfo">
        <p>
            <small>
                <b>
                    <xsl:call-template name="AdditionalInfoSellerSupplierPartyNameTitle" />
                </b>
            </small>
        </p>
        <xsl:call-template name="SellerSupplierPartyName" />
        <br/>
        <xsl:call-template name="SellerSupplierPostalAddress" />
        <div class="box_with_top_margin">
            <small>
                <b>
                    <xsl:call-template name="UMZLabelName">
                        <xsl:with-param name="BT-ID" select="'UMZ-BT-017'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
            </small>
        </div>
        <xsl:call-template name="SellerSupplierPartyLegalEntityID" />
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:Contact !=''">
            <div class="box_with_top_margin">
                <small>
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BG-6'"/>
                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                        </xsl:call-template>
                    </b>
                </small>
            </div>
            <xsl:call-template name="SellerSupplierContact" />
        </xsl:if>
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cbc:EndpointID">
            <div class="box_with_top_margin">
                <small>
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-34'"/>
                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                        </xsl:call-template>
                    </b>
                </small>
            </div>
            <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cbc:EndpointID"/>
            <xsl:if test="cac:SellerSupplierParty/cac:Party/cbc:EndpointID/@schemeID !='' "> 
            [<xsl:value-of select="cac:SellerSupplierParty/cac:Party/cbc:EndpointID/@schemeID"/>]
            </xsl:if>
        </xsl:if>
        <div class="box_with_top_margin">
            <xsl:call-template name="SellerSupplierPartyTaxScheme" />
        </div>
        <div class="box_with_top_margin">
            <xsl:call-template name="SellerSupplierPartyLegalEntity" />
        </div>
    </xsl:template>

    <!--Party legal registration: -->
    <xsl:template name="SellerSupplierPartyLegalEntity">
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity">
            <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID">
                <p>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-47'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                    <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID" />]
                    </xsl:if>
                </p>
            </xsl:if>
            <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                <p>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-27'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                </p>
            </xsl:if>
            <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm != ''">
                <p>
                    <xsl:apply-templates
                            select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm" />
                </p>
            </xsl:if>
            <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress !=''">
                <p>
                    <xsl:choose>
                        <xsl:when test="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !='' and cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                            <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />,&#8201;
                            <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !=''">
                                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />
                            </xsl:if>
                            <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                                <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template name="SellerSupplierPartyTaxScheme">
        <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme">
            <b>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-63'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
            <xsl:if test="cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID" />]
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <!-- /SELLER SUPPLIER PARTY -->
    <!--BUYER PARTY STARTS HERE-->
    <xsl:template name="BuyerPostalID">
        <span class="UBLID">
            <xsl:choose>
                <xsl:when test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID !=''">
                    <xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template name="BuyerID">
        <div class="box_with_top_margin">
            <p>
            <small>
                <b>
                    <xsl:call-template name="UMZLabelName">
                        <xsl:with-param name="BT-ID" select="'UMZ-BT-017'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
            </small>
            </p>
        </div>
        <span class="UBLID">
            <xsl:choose>
                <xsl:when test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ID !=''">
                    <xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ID" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID !=''">
                            <xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template name="BuyerParty">
        <xsl:call-template name="LabelName">
            <xsl:with-param name="BT-ID" select="'BT-45'" />
            <xsl:with-param name="Colon-Suffix" select="'true'" />
        </xsl:call-template>
      
        <xsl:choose>
            <xsl:when test="cac:Party/cac:PartyName">
                <xsl:apply-templates select="cac:Party/cac:PartyName" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
            </xsl:otherwise>
        </xsl:choose>
        <br />
        <b>
            <xsl:call-template name="LabelName">
                <xsl:with-param name="BT-ID" select="'BG-8'" />
                <xsl:with-param name="Colon-Suffix" select="'false'" />
            </xsl:call-template>
        </b>
        <xsl:call-template name="BuyerPostalAddress" />
        <xsl:if test="cac:Party/cac:PartyIdentification/cbc:ID">
            <br />
            <small>
                <b>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-46'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
                <xsl:apply-templates select="cac:Party/cac:PartyIdentification/cbc:ID" />
                <xsl:if test="cac:Party/cac:PartyIdentification/cbc:ID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:Party/cac:PartyIdentification/cbc:ID/@schemeID" />]
                </xsl:if>
            </small>
        </xsl:if>
        <!--Party legal registration: -->
        <xsl:if test="cac:Party/cac:PartyLegalEntity">
            <xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:CompanyID">
                <br />
                <small>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-47'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                    <xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID" />]
                    </xsl:if>
                </small>
            </xsl:if>
            <xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                <br />
                <small>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-44'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                </small>
            </xsl:if>
        </xsl:if>
        <!--Party VAT registration: -->
        <xsl:if test="cac:Party/cac:PartyTaxScheme">
            <small>
                <xsl:if test="cac:Party/cac:PartyTaxScheme">
                    <br />
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-48'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
                    <xsl:if test="cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID" />]
                    </xsl:if>
                </xsl:if>
                <xsl:if test="cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason">
                    <br />
                    <xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason" />
                </xsl:if>
            </small>
        </xsl:if>
    </xsl:template>
    <xsl:template name="BuyerPartyName">
        <xsl:choose>
            <xsl:when test="cac:AccountingCustomerParty/cac:Party/cac:PartyName !=''">
                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyName" />
            </xsl:when>
            <xsl:when test="cac:AccountingCustomerParty/cac:Party/cac:PartyName/cbc:Name !=''">
                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyName/cbc:Name" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates
                        select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="BuyerAdditionalInfo">
        <p>
            <small>
                <b>
                    <xsl:call-template name="AdditionalInfoAccountingCustomerPartyNameTitle" />
                </b>
            </small>
        </p>
        <xsl:call-template name="BuyerPartyName" />
        <br />
        <xsl:call-template name="BuyerPostalAddress" />
        <xsl:call-template name="BuyerID" />
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact !=''">
            <div class="box_with_top_margin">
                <small>
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BG-9'"/>
                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                        </xsl:call-template>
                    </b>
                </small>
            </div>
            <xsl:call-template name="BuyerContact" />
        </xsl:if>
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID">
            <div class="box_with_top_margin">
                <p>
                    <small>
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-49'"/>
                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                            </xsl:call-template>
                        </b>
                    </small>
                </p>
                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID"/>
                <xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID !='' ">
                    [<xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID"/>]
                </xsl:if>
            </div>
        </xsl:if>
        <div class="box_with_top_margin">
            <xsl:call-template name="BuyerPartyTaxScheme" />
        </div>
        <div class="box_with_top_margin">
            <xsl:call-template name="BuyerPartyLegalEntity" />
        </div>
    </xsl:template>

    <!--Party legal registration: -->
    <xsl:template name="BuyerPartyLegalEntity">
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity">
            <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID">
                <p>
                    <small>
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-47'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                    </small>
                </p>    
                    <xsl:apply-templates
                            select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                    <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID" />]
                    </xsl:if>
                <br/>
            </xsl:if>
            <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                <p class="box_with_top_margin">
                    <small>
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-27'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                    </small>
                </p> 
                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                <br/>
            </xsl:if>
            <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm != ''">
                    <xsl:apply-templates
                            select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm" />
                <br/>
            </xsl:if>
            <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress !=''">
                    <xsl:choose>
                        <xsl:when test="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !='' and cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />,&#8201;
                            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !=''">
                                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />
                            </xsl:if>
                            <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                <br/>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template name="BuyerPartyTaxScheme">
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme">
            <p>
                <b>
                    <small>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-63'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                    </small>
                </b>
            </p>
            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
            <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID" />]
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template name="BuyerContact">
    <xsl:param name="ShowLabel" />
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name !=''">
            <xsl:if test="$ShowLabel='true'">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-56'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:if>
            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name" />
            <br />
        </xsl:if>
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telephone !=''">
            <span class="UBLTelephone">
                <xsl:if test="$ShowLabel='true'">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-57'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </xsl:if>
                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telephone" />
            </span>
            <br />
        </xsl:if>
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telefax !=''">
            <span class="UBLTelefax">
                <xsl:if test="$ShowLabel='true'">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-22'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </xsl:if>
                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telefax" />
            </span>
            <br />
        </xsl:if>
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail !=''">
            <span class="UBLElectronicMail">
                <xsl:if test="$ShowLabel='true'">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-58'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </xsl:if>
                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail" />
            </span>
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template name="BuyerPostalAddress">
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName !=''">
            <span class="UBLStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-50'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName" />
            </span>&#8201;
        </xsl:if>
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-51'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates
                    select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line" />
            </span>
        </xsl:if>
        <xsl:if
            test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName !=''">
            <br />
            <span class="UBLCityName">
                <xsl:choose>
                    <xsl:when test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-53'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone" />&#8201;
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-52'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName" />,&#8201;
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-52'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName" />,&#8201;
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:if>
        <xsl:if
            test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country !=''">
            <xsl:choose>
                <xsl:when
                    test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-54'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                        select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />,
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-55'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-54'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />
                    </xsl:if>
                    <xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-55'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode" />
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <!-- /BUYER PARTY -->
    <!-- BUYER CUSTOMER PARTY STARTS HERE -->
    <xsl:template name="AdditionalInfoBuyerCustomerPartyNameTitle">
        <xsl:choose>
            <xsl:when test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress != ''" >
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-020'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-026'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="BuyerCustomerPartyID">
        <xsl:choose>
            <xsl:when test="cac:BuyerCustomerParty/cac:Party/cbc:EndpointID !=''">
                <xsl:value-of select="cac:BuyerCustomerParty/cac:Party/cbc:EndpointID" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="BuyerCustomerPartyName">
        <xsl:choose>
            <xsl:when test="cac:BuyerCustomerParty/cac:Party/cac:PartyName !=''">
                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyName" />
            </xsl:when>
            <xsl:when test="cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name !=''">
                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates
                        select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="BuyerCustomerPostalAddress">
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName !=''">
            <br />
            <span class="UBLStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-50'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-51'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates
                    select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:AdditionalStreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line" />
            </span>
        </xsl:if>
        <xsl:if
            test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName !=''">
            <span class="UBLCityName">
                <br />
                <xsl:choose>
                    <xsl:when test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-53'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone" />&#8201;
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-52'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName" />,&#8201;
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-52'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName" />,&#8201;
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:if>
        <xsl:if
            test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country !=''">
            <xsl:choose>
                <xsl:when
                    test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                    <br />
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-54'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates
                        select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />,
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-55'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-54'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentity" />
                    </xsl:if>
                    <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-55'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates
                            select="cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode" />
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template name="BuyerCustomerPartyAdditionalInfo">
        <p>
            <small>
                <b>
                    <xsl:call-template name="AdditionalInfoBuyerCustomerPartyNameTitle" />
                </b>
            </small>
        </p>
        <xsl:call-template name="BuyerCustomerPartyName" />
        <xsl:call-template name="BuyerCustomerPostalAddress" />
        <div class="box_with_top_margin">
            <small>
                <b>
                    <xsl:call-template name="UMZLabelName">
                        <xsl:with-param name="BT-ID" select="'UMZ-BT-017'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
            </small>
        </div>
        <span class="UBLID">
            <xsl:call-template name="BuyerCustomerPartyID" />
        </span>
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:Contact !=''">
            <div class="box_with_top_margin">
                <small>
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BG-9'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                    </b>
                </small>
            </div>
            <xsl:call-template name="BuyerCustomerPartyContact" />
        </xsl:if>
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cbc:EndpointID">
            <p>
                <div class="box_with_top_margin">
                    <small>
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-49'"/>
                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                            </xsl:call-template>
                        </b>
                    </small>
                </div>
                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cbc:EndpointID"/>
                <xsl:if test="cac:BuyerCustomerParty/cac:Party/cbc:EndpointID/@schemeID !='' ">
                    [<xsl:value-of select="cac:BuyerCustomerParty/cac:Party/cbc:EndpointID/@schemeID"/>]
                </xsl:if>
            </p>
        </xsl:if>
        <div class="box_with_top_margin">
            <xsl:call-template name="BuyerCustomerPartyTaxScheme" />
        </div>
        <div class="box_with_top_margin">
            <xsl:call-template name="BuyerCustomerLegalEntity" />
        </div>
    </xsl:template>
    <xsl:template name="BuyerCustomerPartyContact">
        <xsl:param name="ShowLabel" />
        <xsl:if test="((cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name !='') and (cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name != cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name))">
            <p class="UBLName">
                <xsl:if test="$ShowLabel='true'">
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-56'"/>
                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                        </xsl:call-template>
                    </b>
                </xsl:if>
                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name"/>
            </p>
        </xsl:if>
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Telephone !=''">
            <span class="UBLTelephone">
                <xsl:if test="$ShowLabel='true'"> 
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-57'"/>
                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                        </xsl:call-template>
                    </b>
                </xsl:if> 
                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Telephone" />
            </span>
        </xsl:if>
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Telefax !=''">
            <br />
            <span class="UBLTelefax">
                <xsl:if test="$ShowLabel='true'"> 
                    <b>
                        <xsl:call-template name="UMZLabelName">
                            <xsl:with-param name="BT-ID" select="'UMZ-BT-001'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                    </b>
                </xsl:if> 
                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Telefax" />
            </span>
        </xsl:if>
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail !=''">
            <br />
            <span class="UBLElectronicMail">
                <xsl:if test="$ShowLabel='true'"> 
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-58'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                    </b>
                </xsl:if> 
                <xsl:apply-templates
                        select="cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail" />
            </span>
        </xsl:if>
    </xsl:template>
    <xsl:template name="BuyerCustomerPartyTaxScheme">
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme">
            <b>
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-032'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
            <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID" />]
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <!--Party legal registration: -->
    <xsl:template name="BuyerCustomerLegalEntity">
        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity">
            <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID">
                <p>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-47'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates
                        select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID" />]
                </xsl:if>
                </p>
            </xsl:if>
            <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                <p>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-27'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates
                        select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName" />
                </p>
            </xsl:if>
            <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm != ''">
                <p>
                <xsl:apply-templates
                        select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm" />
                </p>
            </xsl:if>
            <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress !=''">
                <p>
                <xsl:choose>
                    <xsl:when test="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !='' and cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                        <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />,&#8201;
                        <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !=''">
                            <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName" />
                        </xsl:if>
                        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
                            <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country" />
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                </p>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <!-- /BUYER CUSTOMER PARTY -->
    <!-- PAYEE PARTY STARTS HERE-->
    <xsl:template name="PayeeParty">
        <xsl:call-template name="LabelName">
            <xsl:with-param name="BT-ID" select="'BT-59'" />
            <xsl:with-param name="Colon-Suffix" select="'true'" />
        </xsl:call-template>
        <xsl:apply-templates select="cac:PayeeParty/cac:PartyName" />
        <xsl:if test="cac:PayeeParty/cac:PartyIdentification/cbc:ID">
            <br />
            <small>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-60'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:PayeeParty/cac:PartyIdentification/cbc:ID" />
                <xsl:if test="cac:PayeeParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:PayeeParty/cac:PartyIdentification/cbc:ID/@schemeID" />]
                </xsl:if>
            </small>
        </xsl:if>
        <!--Party legal registration: -->
        <xsl:if test="cac:PayeeParty/cac:PartyLegalEntity">
            <xsl:if test="cac:PayeeParty/cac:PartyLegalEntity">
                <br />
                <small>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-61'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID" />
                    <xsl:if test="cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID/@schemeID" />]
                    </xsl:if>
                </small>
            </xsl:if>
        </xsl:if>
        <!--Party VAT registration: -->
        <xsl:if test="cac:PayeeParty/cac:PartyTaxScheme">
            <small>
                <xsl:if test="cac:PayeeParty/cac:PartyTaxScheme">
                    <br />
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-63'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cac:PayeeParty/cac:PartyTaxScheme/cbc:CompanyID" />
                    <xsl:if test="cac:PayeeParty/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:PayeeParty/cac:PartyTaxScheme/cbc:CompanyID/@schemeID" />]
                    </xsl:if>
                </xsl:if>
            </small>
        </xsl:if>
    </xsl:template>
    <xsl:template name="PayeePartyName">
        <xsl:if test="cac:PayeeParty/cbc:Name !=''">
            <xsl:apply-templates select="cbc:Name" />
        </xsl:if>
    </xsl:template>
    <xsl:template match="cac:PartyName">
        <xsl:if test="cbc:Name !=''">
            <xsl:apply-templates select="cbc:Name" />
        </xsl:if>
    </xsl:template>
    <!-- /PAYEE PARTY -->
    <!-- ORIGINATOR CUSTOMER PARTY STARTS HERE-->
    <xsl:template name="OriginatorCustomerParty">
        <xsl:call-template name="OriginatorCustomerPartyName" />
        <xsl:if test="cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
            <br />
            <b>
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-046'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID" />
            <xsl:if test="cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID/@schemeID !='' ">&#8201;[<xsl:apply-templates select="cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID/@schemeID" />]
            </xsl:if>
        </xsl:if>
        <br />
        <xsl:call-template name="OriginatorCustomerPartyContact" />
    </xsl:template>
    <xsl:template name="OriginatorCustomerPartyName">
        <xsl:if test="cac:OriginatorCustomerParty/cac:Party/cac:PartyName/cbc:Name !=''">
            <b>
                <xsl:call-template name="UMZLabelName">
                    <xsl:with-param name="BT-ID" select="'UMZ-BT-026'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cac:OriginatorCustomerParty/cac:Party/cac:PartyName/cbc:Name" />
        </xsl:if>
    </xsl:template>
    <xsl:template name="OriginatorCustomerPartyContact">
        <xsl:if test="cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Telephone !=''">
            <span class="UBLTelephone">
                <b class="seller_contact_label">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-42'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
                <xsl:apply-templates select="cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Telephone" />
            </span>
        </xsl:if>
        <xsl:if test="cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name !=''">
            <br />
            <span class="UBLName">
                <b class="seller_contact_label">
                    <xsl:call-template name="UMZLabelName">
                        <xsl:with-param name="BT-ID" select="'UMZ-BT-028'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
                <xsl:apply-templates select="cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name" />
            </span>
        </xsl:if>
        <xsl:if test="cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Telefax !=''">
            <br />
            <span class="UBLTelefax">
                <b class="seller_contact_label">
                    <xsl:call-template name="UMZLabelName">
                        <xsl:with-param name="BT-ID" select="'UMZ-BT-001'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
                <xsl:apply-templates select="cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Telefax" />
            </span>
        </xsl:if>
        <xsl:if test="cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail !=''">
            <br />
            <span class="UBLElectronicMail">
                <b class="seller_contact_label">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-43'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
                <xsl:apply-templates select="cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail" />
            </span>
        </xsl:if>
    </xsl:template>
    <!-- /ORIGINATOR CUSTOMER PARTY -->
    <xsl:template match="cac:PostalAddress | cac:DeliveryAddress | cac:Address ">
        <xsl:if test="cbc:StreetName !=''">
            <br />
            <span class="UBLStreetName">
                <xsl:apply-templates select="cbc:StreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cbc:AdditionalStreetName !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:apply-templates select="cbc:AdditionalStreetName" />
            </span>
        </xsl:if>
        <xsl:if test="cac:AddressLine/cbc:Line !=''">
            <br />
            <span class="UBLAdditionalStreetName">
                <xsl:apply-templates select="cac:AddressLine/cbc:Line" />
            </span>
        </xsl:if>
        <xsl:if test="cbc:PostalZone !='' or cbc:CityName !=''">
            <br />
            <span class="UBLCityName">
                <xsl:choose>
                    <xsl:when test="cbc:PostalZone !=''">
                        <xsl:apply-templates select="cbc:PostalZone" />&#8201;<xsl:apply-templates select="cbc:CityName" />,&#8201;
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="cbc:CityName" />,&#8201;
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:if>
        <xsl:if test="cbc:CountrySubentity !='' or cac:Country !=''">
            <xsl:choose>
                <xsl:when test="cbc:CountrySubentity !='' and cac:Country !=''">
                    <br />
                    <xsl:apply-templates select="cbc:CountrySubentity" />,
                    <xsl:apply-templates select="cac:Country" />
                    <br />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="cbc:CountrySubentity !=''">
                        <xsl:apply-templates select="cbc:CountrySubentity" />
                    </xsl:if>
                    <xsl:if test="cac:Country !=''">
                        <xsl:apply-templates select="cac:Country/cbc:IdentificationCode" />
                    </xsl:if>
                    <br />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template match="cac:Country">
        <span>
            <xsl:apply-templates select="cbc:IdentificationCode" />
            <!-- Checking of listID (normally NOT a function of a stylesheet): -->
            <xsl:if test="cbc:IdentificationCode/@listID !=''">
                <xsl:if test="cbc:IdentificationCode/@listID !='ISO3166-1:Alpha2'">&#8201;
                    <small>
                        <em>[<xsl:apply-templates select="cbc:IdentificationCode/@listID" />&#8201;-invalid listID]</em>
                    </small>
                </xsl:if>
            </xsl:if>
        </span>
    </xsl:template>
    <!--TaxRepresentativeParty Starts here:-->
    <xsl:template match="cac:TaxRepresentativeParty">
        <xsl:if test="cac:PartyName/cbc:Name !=''">
            <xsl:value-of select="cac:PartyName/cbc:Name" />
            <br />
        </xsl:if>
        <xsl:if test="cac:PostalAddress/cbc:StreetName !=''">
            <xsl:apply-templates select="cac:PostalAddress/cbc:StreetName" />
            <br />
        </xsl:if>
        <xsl:if test="cac:PostalAddress/cbc:AdditionalStreetName !=''">
            <xsl:apply-templates select="cac:PostalAddress/cbc:AdditionalStreetName" />
            <br />
        </xsl:if>
        <xsl:if test="cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
            <xsl:apply-templates select="cac:PostalAddress/cac:AddressLine/cbc:Line" />
            <br />
        </xsl:if>
        <xsl:if test="cac:PostalAddress/cbc:PostalZone !='' or cac:PostalAddress/cbc:CityName !=''">
            <xsl:choose>
                <xsl:when test="cac:PostalAddress/cbc:PostalZone !=''">
                    <xsl:apply-templates select="cac:PostalAddress/cbc:PostalZone" />&#8201;
                    <xsl:apply-templates select="cac:PostalAddress/cbc:CityName" />
                    <br />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="cac:PostalAddress/cbc:CityName" />
                    <br />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="cac:PostalAddress/cbc:CountrySubentity !='' or cac:PostalAddress/cac:Country !=''">
            <xsl:choose>
                <xsl:when test="cac:PostalAddress/cbc:CountrySubentity !='' and cac:PostalAddress/cac:Country !=''">
                    <xsl:apply-templates select="cac:PostalAddress/cbc:CountrySubentity" />,
                    <xsl:apply-templates select="cac:PostalAddress/cac:Country" />
                    <br />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="cac:PostalAddress/cbc:CountrySubentity !=''">
                        <xsl:apply-templates select="cac:PostalAddress/cbc:CountrySubentity" />
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:PostalAddress/cac:Country !=''">
                        <xsl:apply-templates select="cac:PostalAddress/cac:Country/cbc:IdentificationCode" />
                        <br />
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="cac:PartyTaxScheme/cbc:CompanyID !=''">
            <small>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-63'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:value-of select="cac:PartyTaxScheme/cbc:CompanyID" />
            </small>
        </xsl:if>
    </xsl:template>
    <!--Delivery templates start: -->
    <xsl:template match="cac:Delivery" mode="DocumentHeader">
        <p>
            <xsl:if test="cac:DeliveryParty/cac:PartyName !=''">
                <xsl:call-template name="DeliveryPartyName" />
            </xsl:if>
        </p>
        <p>
            <xsl:if test="cac:DeliveryParty/cac:PartyIdentification !=''">
                <xsl:call-template name="DeliveryPartyIdentification" />
            </xsl:if>
        </p>
        <p>
            <xsl:if test="cac:RequestedDeliveryPeriod !=''">
                <xsl:call-template name="RequestedDeliveryPeriod" />
            </xsl:if>
        </p>
        <p>
            <xsl:if test="cac:DeliveryParty/cac:Contact !=''">
                <xsl:call-template name="DeliveryContact" />
            </xsl:if>
        </p>
        <p>
            <xsl:if test="cac:DeliveryLocation !=''">
                <xsl:apply-templates select="cac:DeliveryLocation" />
            </xsl:if>
        </p>
    </xsl:template>
    <xsl:template name="DeliveryPartyName">
        <xsl:if test="cac:Delivery/cac:DeliveryParty/cac:PartyName/cbc:Name != ''">
            <xsl:apply-templates select="cac:Delivery/cac:DeliveryParty/cac:PartyName/cbc:Name" />
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template name="DeliveryPartyIdentification">
        <xsl:if test="cac:DeliveryParty/cac:PartyIdentification/cbc:ID">
            <xsl:apply-templates select="cac:DeliveryParty/cac:PartyIdentification/cbc:ID"/>
            <xsl:if test="cac:DeliveryParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">
            [<xsl:value-of select="cac:DeliveryParty/cac:PartyIdentification/cbc:ID/@schemeID"/>]
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="cac:DeliveryLocation">
        <xsl:if test="cbc:ID !=''">
            <div class="box_with_top_margin">
                <small>
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-71'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>    
                    </b>
                </small>
            </div>
            <xsl:apply-templates select="cbc:ID" />
            <xsl:choose>
                <xsl:when test="cbc:ID/@schemeID !=''">
                    &#8201;[<xsl:apply-templates select="cbc:ID/@schemeID" />]
                </xsl:when>
                <xsl:otherwise>
                    &#8201;[No schemeID]
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="cac:Address !=''">
        <div class="box_with_top_margin">
            <xsl:call-template name="DeliveryAddress" />
        </div>
        </xsl:if>
    </xsl:template>
    <xsl:template name="DeliveryAddress">
        <xsl:if test="cac:Address/cbc:StreetName !=''">
            <p class="UBLStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-75'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:Address/cbc:StreetName" />
            </p>
        </xsl:if>
        <xsl:if test="cac:Address/cbc:AdditionalStreetName !=''">
            <p class="UBLAdditionalStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-76'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:Address/cbc:AdditionalStreetName" />
            </p>
        </xsl:if>
        <xsl:if test="cac:Address/cac:AddressLine/cbc:Line !=''">
            <p class="UBLAdditionalStreetName">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-165'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:Address/cac:AddressLine/cbc:Line" />
            </p>
        </xsl:if>
        <xsl:if test="cac:Address/cbc:Department !=''">
            <p class="UBLcbc:Department">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-75'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cac:Address/cbc:Department" />
            </p>
        </xsl:if>
        <p class="UBLCityName">
            <xsl:if test="cac:Address/cbc:PostalZone !='' or cac:Address/cbc:CityName !=''">
                <xsl:choose>
                    <xsl:when test="cac:Address/cbc:PostalZone !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-78'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:Address/cbc:PostalZone" />&#8201;
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-77'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:Address/cbc:CityName" />,&#8201;
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-77'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:Address/cbc:CityName" />,&#8201;
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="cac:Address/cbc:CountrySubentity !='' or cac:Address/cac:Country !=''">
                <xsl:choose>
                    <xsl:when test="cac:Address/cbc:CountrySubentity !='' and cac:Address/cac:Country !=''">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-79'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:Address/cbc:CountrySubentity" />,
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-80'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                        <xsl:apply-templates select="cac:Address/cac:Country" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="cac:Address/cbc:CountrySubentity !=''">
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-79'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                            <xsl:apply-templates select="cac:Address/cbc:CountrySubentity" />
                        </xsl:if>
                        <xsl:if test="cac:Address/cac:Country !=''">
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-80'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                            <xsl:apply-templates select="cac:Address/cac:Country/cbc:IdentificationCode" />
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </p>
    </xsl:template>
    <xsl:template name="ActualDeliveryDate">
        <div class="box_with_top_margin">
            <p class="UBLActualDeliveryDate">
                <xsl:if test="cac:Delivery/cbc:ActualDeliveryDate !=' '">
                    <xsl:if test="cac:Delivery/cbc:ActualDeliveryDate !=''">                    
                            <small>
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-72'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </b>
                            </small>
                            <br/>
                            <xsl:apply-templates select="cac:Delivery/cbc:ActualDeliveryDate"/>                    
                    </xsl:if>
                </xsl:if>
            </p>
        </div>
    </xsl:template>
    <xsl:template name="RequestedDeliveryPeriod">
        <xsl:if test="cac:Delivery/cac:RequestedDeliveryPeriod/cbc:StartDate !=''">
            <br />
            <b>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-73'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cac:Delivery/cac:RequestedDeliveryPeriod/cbc:StartDate" />
        </xsl:if>
        <xsl:if test="cac:RequestedDeliveryPeriod/cbc:StartDate !=''">
            <br />
            <b>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-73'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cac:RequestedDeliveryPeriod/cbc:StartDate" />
        </xsl:if>
        <xsl:if test="cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate !=''">
            <br />
            <b>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-74'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate" />
        </xsl:if>
        <xsl:if test="cac:RequestedDeliveryPeriod/cbc:EndDate !=''">
            <br />
            <b>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-74'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cac:RequestedDeliveryPeriod/cbc:EndDate" />
        </xsl:if>
        <br />
    </xsl:template>
    <xsl:template name="DeliveryContact">
        <xsl:if test="cac:DeliveryParty/cac:Contact/cbc:Name !=''">
            <p class="UBLName">
                <xsl:apply-templates select="cac:DeliveryParty/cac:Contact/cbc:Name"/>
            </p>
        </xsl:if>
        <xsl:if test="cac:DeliveryParty/cac:Contact/cbc:Telephone !=''">
            <span class="UBLTelephone">
                <xsl:apply-templates select="cac:DeliveryParty/cac:Contact/cbc:Telephone" />
            </span>
        </xsl:if>
        <xsl:if test="cac:DeliveryParty/cac:Contact/cbc:ElectronicMail !=''">
            <br />
            <span class="UBLElectronicMail">
                <xsl:apply-templates select="cac:DeliveryParty/cac:Contact/cbc:ElectronicMail" />
            </span>
        </xsl:if>
    </xsl:template>
    <!--Contact from here: -->
    <xsl:template match="cac:AccountingSupplierParty/cac:Party" mode="accsupcontact">
        <xsl:apply-templates select="cac:Contact" />
    </xsl:template>
    <xsl:template match="cac:AccountingCustomerParty/cac:Party" mode="acccuscontact">
        <xsl:apply-templates select="cac:Contact" />
    </xsl:template>
    <!--Invoiceline start: -->
    <xsl:template match="cac:InvoiceLine | cac:CreditNoteLine | cac:OrderLine/cac:LineItem">
        <input type="checkbox" name="one" class="hide_content_input">
            <xsl:attribute name="id">
                <xsl:apply-templates select="cbc:ID" />
            </xsl:attribute>
        </input>
        <div class="items_table_body_holder">
            <div class="items_table_body_data">
                <label>
                    <xsl:attribute name="for">
                        <xsl:apply-templates select="cbc:ID" />
                    </xsl:attribute>
                    <span class="expand_arrow">&#8249;</span>
                    <xsl:apply-templates select="cbc:ID" />.
                </label>
            </div>
            <div class="items_table_body_data">
                <xsl:apply-templates select="cac:Item/cac:SellersItemIdentification" />
            </div>
            <div class="items_table_body_data">
                <div class="items_table_body_data_name_column_header">
                    <xsl:apply-templates select="cac:Item/cbc:Name" />
                </div>
                <small class="hide_content items_table_body_data_name_column_body">
                    <xsl:if test="../cac:LineItem !=''">
                        <xsl:if test="../cbc:Note !=''">
                            <b>
                                <xsl:call-template name="LabelName">
                                    <xsl:with-param name="BT-ID" select="'BT-127'" />
                                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                                </xsl:call-template>
                            </b>
                            <xsl:apply-templates select="../cbc:Note" />
                            <br />
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="cac:Item/cac:StandardItemIdentification/cbc:ID !=''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-157'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cac:Item/cac:StandardItemIdentification/cbc:ID" />
                        <xsl:choose>
                            <xsl:when test="cac:Item/cac:StandardItemIdentification/cbc:ID/@schemeID !=''">
                                <small>
                                    &#8201;[<xsl:apply-templates select="cac:Item/cac:StandardItemIdentification/cbc:ID/@schemeID" />]
                                </small>
                            </xsl:when>
                            <xsl:otherwise>
                                <small>&#8201;[No schemeID]</small>
                            </xsl:otherwise>
                        </xsl:choose>
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:Item/cbc:Description !=''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-154'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cac:Item/cbc:Description" />
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:Item/cac:AdditionalItemProperty !=''">
                        <xsl:apply-templates select="cac:Item/cac:AdditionalItemProperty" />
                    </xsl:if>
                    <xsl:if test="cac:Item/cac:ItemInstance !=''">
                        <xsl:if test="cac:Item/cac:ItemInstance/cbc:SerialID !=''">
                            <b>
                                <xsl:call-template name="UMZLabelName">
                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-033'" />
                                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                                </xsl:call-template>
                            </b>
                            <xsl:apply-templates select="cac:Item/cac:ItemInstance/cbc:SerialID" />
                            <br />
                        </xsl:if>
                        <xsl:if test="cac:Item/cac:ItemInstance/cac:LotIdentification/cbc:LotNumberID !=''">
                            <b>
                                <xsl:call-template name="UMZLabelName">
                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-034'" />
                                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                                </xsl:call-template>
                            </b>
                            <xsl:apply-templates select="cac:Item/cac:ItemInstance/cac:LotIdentification/cbc:LotNumberID" />
                            <br />
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="cbc:Note !=''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-127'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cbc:Note" />
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:Item/cac:CommodityClassification !=''">
                        <xsl:apply-templates select="cac:Item/cac:CommodityClassification" />
                    </xsl:if>
                    <xsl:if test="cac:Item/cac:ItemSpecificationDocumentReference/cbc:ID != ''">
                        <b>
                            <xsl:call-template name="UMZLabelName">
                                <xsl:with-param name="BT-ID" select="'UMZ-BT-040'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cac:Item/cac:ItemSpecificationDocumentReference/cbc:ID" />
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:Item/cac:BuyersItemIdentification/cbc:ID != ''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-156'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cac:Item/cac:BuyersItemIdentification/cbc:ID" />
                        <br />
                    </xsl:if>
                    <xsl:if test="cbc:AccountingCost !=''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-19'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cbc:AccountingCost" />
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:InvoicePeriod !=''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BG-14'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cac:InvoicePeriod" />
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:Price/cac:AllowanceCharge !=''">
                        <xsl:apply-templates select="cac:Price/cac:AllowanceCharge" mode="PriceUnit-new" />
                    </xsl:if>
                    <xsl:if test="cac:Item/cac:OriginCountry/cbc:IdentificationCode !=''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-159'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cac:Item/cac:OriginCountry/cbc:IdentificationCode" />
                        <xsl:if test="cac:Item/cac:OriginCountry/cbc:IdentificationCode/@listID !=''">
                            <small>
                                &#8201;[<xsl:apply-templates select="cac:Item/cac:OriginCountry/cbc:IdentificationCode/@listID" />]
                            </small>
                        </xsl:if>
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:OrderLineReference/cbc:LineID !=''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-132'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cac:OrderLineReference/cbc:LineID" />
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:DocumentReference/cbc:ID !=''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-128'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cac:DocumentReference/cbc:ID" />
                            [<xsl:apply-templates select="cac:DocumentReference/cbc:ID/@schemeID" />]
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:AllowanceCharge !=''">
                        <xsl:for-each select="cac:AllowanceCharge">
                            <xsl:if test="position()!=1">
                                <br />
                            </xsl:if>
                            <b>
                                <xsl:call-template name="LabelName">
                                    <xsl:with-param name="BT-ID" select="'BT-98'" />
                                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                                </xsl:call-template>
                            </b>
                            <xsl:if test="cbc:AllowanceChargeReason !=''">
                                <xsl:apply-templates select="cbc:AllowanceChargeReason" />
                            </xsl:if>
                            <xsl:if test="cbc:AllowanceChargeReasonCode !=''">
                                [<xsl:apply-templates select="cbc:AllowanceChargeReasonCode" />] -
                                <xsl:call-template name="AllowanceReasonCode">
                                    <xsl:with-param name="AllowanceCode" select="cbc:AllowanceChargeReasonCode"/>
                                </xsl:call-template>&#8201;
                            </xsl:if>
                            <xsl:if test="cbc:MultiplierFactorNumeric !=''">
                                <xsl:apply-templates select="cbc:MultiplierFactorNumeric" />%
                            </xsl:if>
                            <br />
                            <xsl:if test="cbc:Amount !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-136'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cbc:Amount" />
                            </xsl:if>
                            <xsl:if test="cbc:BaseAmount !=''">
                                <br />
                                <b>
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-035'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cbc:BaseAmount" />
                            </xsl:if>
                        </xsl:for-each>
                        <br />
                    </xsl:if>
                    <xsl:if test="cac:Delivery/cac:RequestedDeliveryPeriod !=''">
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BG-13'" />
                                <xsl:with-param name="Colon-Suffix" select="'false'" />
                            </xsl:call-template>
                        </b>
                        <xsl:call-template name="RequestedDeliveryPeriod"/>
                    </xsl:if>
                    <xsl:if test="cac:OriginatorParty !=''">
                        <b>
                            <xsl:call-template name="UMZLabelName">
                                <xsl:with-param name="BT-ID" select="'UMZ-BT-036'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:if test="cac:OriginatorParty/cac:PartyName/cbc:Name">
                            <xsl:apply-templates select="cac:OriginatorParty/cac:PartyName/cbc:Name"/>&#8201;
                        </xsl:if>
                        <xsl:if test="cac:OriginatorParty/cac:PartyIdentification/cbc:ID">
                            <xsl:apply-templates select="cac:OriginatorParty/cac:PartyIdentification/cbc:ID"/>
                            <xsl:if test="cac:OriginatorParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">
                            [<xsl:value-of select="cac:OriginatorParty/cac:PartyIdentification/cbc:ID/@schemeID"/>]
                            </xsl:if>
                        </xsl:if>
                        <br />
                    </xsl:if>
                </small>
            </div>
            <div class="items_table_body_data">
                <xsl:if test="cbc:InvoicedQuantity !=''">
                    <xsl:apply-templates select="cbc:InvoicedQuantity" />&#8201;
                    <xsl:if test="cbc:InvoicedQuantity/@unitCode !=''">
                        <xsl:value-of select="cbc:InvoicedQuantity/@unitCode" />
                        <small class="hide_content">
                            <br/>
                            [<xsl:call-template name="UNECECode">
                                <xsl:with-param name="Code" select="cbc:InvoicedQuantity/@unitCode" />
                            </xsl:call-template>]
                        </small>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="cbc:CreditedQuantity !=''">
                    <xsl:apply-templates select="cbc:CreditedQuantity" />&#8201;
                    <xsl:if test="cbc:CreditedQuantity/@unitCode !=''">
                        <xsl:value-of select="cbc:CreditedQuantity/@unitCode" />
                        <small class="hide_content">
                            <br/>
                            [<xsl:call-template name="UNECECode">
                                <xsl:with-param name="Code" select="cbc:CreditedQuantity/@unitCode" />
                            </xsl:call-template>]
                        </small>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="cbc:Quantity !=''">
                    <xsl:apply-templates select="cbc:Quantity" />&#8201;
                    <xsl:if test="cbc:Quantity/@unitCode !=''">
                        <xsl:value-of select="cbc:Quantity/@unitCode" />
                        <small class="hide_content">
                            <br />
                            [<xsl:call-template name="UNECECode">
                                <xsl:with-param name="Code" select="cbc:Quantity/@unitCode" />
                            </xsl:call-template>]
                        </small>
                    </xsl:if>
                </xsl:if>
            </div>
            <div class="items_table_body_data">
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cac:Price/cbc:PriceAmount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
                <xsl:if test="cac:Price/cbc:BaseQuantity">
                    <small class="hide_content">
                        <br />
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-149'" />
                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                            </xsl:call-template>
                        </b>
                        <xsl:apply-templates select="cac:Price/cbc:BaseQuantity" />
                    </small>
                </xsl:if>
            </div>
            <div class="items_table_body_data">
                <xsl:if test="cac:Item/cac:ClassifiedTaxCategory !='' ">
                    <xsl:choose>
                        <xsl:when test="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent !=''">
                            <xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cbc:ID" />
                            <xsl:call-template name="NumberFormat">
                                <xsl:with-param name="value" select="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent" />
                                <xsl:with-param name="formatToDecimal" select="'false'" />
                                <xsl:with-param name="country" select="$languageCode" />
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:ID" />
                            <xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cbc:ID" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <xsl:if test="cac:TaxTotal/cbc:TaxAmount">
                    <div class="hide_content">
                        <small>
                            <xsl:choose>
                                <xsl:when test="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent !=''">
                                    [<xsl:call-template name="Currency">
                                        <xsl:with-param name="currencyvalue" select="cac:TaxTotal/cbc:TaxAmount" />
                                        <xsl:with-param name="country" select="$languageCode" />
                                    </xsl:call-template>]
                                </xsl:when>
                                <xsl:otherwise>
                                    [<xsl:call-template name="Currency">
                                        <xsl:with-param name="currencyvalue" select="cac:TaxTotal/cbc:TaxAmount" />
                                        <xsl:with-param name="country" select="$languageCode" />
                                    </xsl:call-template>]
                                </xsl:otherwise>
                            </xsl:choose>
                        </small>
                    </div>
                </xsl:if>
            </div>
            <div class="items_table_body_data text_right">
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cbc:LineExtensionAmount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
            </div>
            <div class="items_table_body_data text_right">
                <xsl:choose>
                    <xsl:when test="((cac:Item/cac:ClassifiedTaxCategory/cbc:Percent !='') and (cbc:LineExtensionAmount !=''))">
                        <xsl:variable name="taxInclusiveAmount" select="format-number((number(cac:Item/cac:ClassifiedTaxCategory/cbc:Percent) div 100)*number(cbc:LineExtensionAmount)+number(cbc:LineExtensionAmount),'#.00')" />
                        <xsl:call-template name="Currency">
                            <xsl:with-param name="currencyvalue" select="$taxInclusiveAmount" />
                            <xsl:with-param name="country" select="$languageCode" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="((cac:TaxTotal/cbc:TaxAmount !='') and (cbc:LineExtensionAmount !=''))">
                                <xsl:variable name="taxInclusiveAmount" select="format-number(round(number(cbc:LineExtensionAmount))+round(number(cac:TaxTotal/cbc:TaxAmount)),'#.00')" />
                                <xsl:call-template name="Currency">
                                    <xsl:with-param name="currencyvalue" select="$taxInclusiveAmount" />
                                    <xsl:with-param name="country" select="$languageCode" />
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount !=''">
                                    <xsl:call-template name="Currency">
                                        <xsl:with-param name="currencyvalue"
                                            select="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount" />
                                        <xsl:with-param name="country" select="$languageCode" />
                                    </xsl:call-template>
                                </xsl:if>
                                <xsl:if test="../cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount !=''">
                                    <xsl:call-template name="Currency">
                                        <xsl:with-param name="currencyvalue"
                                            select="../cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount" />
                                        <xsl:with-param name="country" select="$languageCode" />
                                    </xsl:call-template>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="cac:CommodityClassification">
        <xsl:if test="cbc:CommodityCode !=''">
            <b>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-158'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cbc:CommodityCode" />
            <xsl:choose>
                <xsl:when test="cbc:CommodityCode/@listID !=''">
                    <small>&#8201;
                    [<xsl:call-template name="UBLClassificationCode">
                            <xsl:with-param name="Code" select="cbc:CommodityCode/@listID" />
                        </xsl:call-template>]
                    </small>
                </xsl:when>
                <xsl:otherwise>
                    <small>&#8201;[No listID]</small>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="cbc:CommodityCode/@listVersionID !=''">
                [<xsl:apply-templates select="cbc:CommodityCode/@listeVersionID" />]
            </xsl:if>
            <br />
        </xsl:if>
        <xsl:if test="cbc:ItemClassificationCode !=''">
            <b>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-158'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:apply-templates select="cbc:ItemClassificationCode" />
            <xsl:choose>
                <xsl:when test="cbc:ItemClassificationCode/@listID !=''">
                    <small>&#8201;
                    [<xsl:call-template name="UBLClassificationCode">
                            <xsl:with-param name="Code" select="cbc:ItemClassificationCode/@listID" />
                        </xsl:call-template>]
                    </small>
                </xsl:when>
                <xsl:otherwise>
                    <small>&#8201;[No listID]</small>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="cbc:ItemClassificationCode/@listVersionID !=''">
                [<xsl:apply-templates select="cbc:ItemClassificationCode/@listVersionID" />]
            </xsl:if>
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="cac:AdditionalItemProperty">
        <b>
            <xsl:call-template name="LabelName">
                <xsl:with-param name="BT-ID" select="'BT-160'" />
                <xsl:with-param name="Colon-Suffix" select="'true'" />
            </xsl:call-template>
        </b>
        <xsl:apply-templates select="cbc:Name" /> =
        <xsl:apply-templates select="cbc:Value" />
        <br />
    </xsl:template>
    <xsl:template match="cac:SellersItemIdentification">
        <xsl:apply-templates select="cbc:ID" />
    </xsl:template>
    <xsl:template match="cac:Price">
        <xsl:call-template name="Currency">
            <xsl:with-param name="currencyvalue" select="cbc:PriceAmount" />
            <xsl:with-param name="country" select="$languageCode" />
        </xsl:call-template>&#8201;
        <xsl:apply-templates select="cbc:PriceAmount/@currencyID" />
    </xsl:template>
    <!--Invoiceline end-->
    <!-- Document legal totals from here-->
    <!-- Document legal totals until here-->
    <!--Allowance/Charge from here-->
    <!-- 1) A/C on document level -->
    <xsl:template match="cac:AllowanceCharge" mode="DocumentLevel-new">
        <tr>
            <td valign="top" colspan="2">
                <xsl:choose>
                    <xsl:when test="cbc:ChargeIndicator ='true'">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BG-21'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="cbc:ChargeIndicator ='false'">
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BG-20'" />
                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise />
                </xsl:choose>
            </td>
            <td valign="top" colspan="2">
                <xsl:if test="cbc:AllowanceChargeReasonCode !=''">
                    <xsl:apply-templates select="cbc:AllowanceChargeReasonCode" />
                </xsl:if>
            </td>
            <td valign="top" colspan="2">
                <xsl:apply-templates select="cbc:AllowanceChargeReason" />
            </td>
            <td>
                <xsl:if test="cac:TaxCategory !='' ">
                    <xsl:choose>
                        <xsl:when test="cac:TaxCategory/cbc:Percent !=''">
                            <xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID" />:&#8201;
                            <xsl:apply-templates select="cac:TaxCategory/cbc:ID" />,&#8201;
                            <xsl:apply-templates select="cac:TaxCategory/cbc:Percent" />%
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID" />:&#8201;
                            <xsl:apply-templates select="cac:TaxCategory/cbc:ID" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </td>
            <td valign="top" align="right">
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cbc:Amount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>
    <xsl:template name="Allowance">
        <tr>
            <td valign="top" colspan="2">
                <xsl:apply-templates select="cbc:AllowanceChargeReasonCode" />
            </td>
            <td valign="top" colspan="2">
                <xsl:apply-templates select="cbc:AllowanceChargeReason" />
            </td>
            <td>
                <xsl:if test="cac:TaxCategory !='' ">
                    <xsl:choose>
                        <xsl:when test="cac:TaxCategory/cbc:Percent !=''">
                            <xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID" />:&#8201;
                            <xsl:apply-templates select="cac:TaxCategory/cbc:ID" />,&#8201;
                            <xsl:apply-templates select="cac:TaxCategory/cbc:Percent" />%
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID" />:&#8201;
                            <xsl:apply-templates select="cac:TaxCategory/cbc:ID" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </td>
            <td valign="top" align="right">
                <xsl:if test="cbc:MultiplierFactorNumeric != ''">
                    <xsl:apply-templates select="cbc:MultiplierFactorNumeric" />% of
                </xsl:if>
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cbc:BaseAmount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
            </td>
            <td valign="top" align="right">
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cbc:Amount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>
    <xsl:template name="Charge">
        <tr>
            <td valign="top" colspan="2">
                <xsl:apply-templates select="cbc:AllowanceChargeReasonCode" />
            </td>
            <td valign="top" colspan="2">
                <xsl:apply-templates select="cbc:AllowanceChargeReason" />
            </td>
            <td>
                <xsl:if test="cac:TaxCategory !='' ">
                    <xsl:choose>
                        <xsl:when test="cac:TaxCategory/cbc:Percent !=''">
                            <xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID" />:&#8201;
                            <xsl:apply-templates select="cac:TaxCategory/cbc:ID" />,&#8201;
                            <xsl:apply-templates select="cac:TaxCategory/cbc:Percent" />%
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID" />:&#8201;
                            <xsl:apply-templates select="cac:TaxCategory/cbc:ID" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </td>
            <td valign="top" align="right">
                <xsl:if test="cbc:MultiplierFactorNumeric != ''">
                    <xsl:apply-templates select="cbc:MultiplierFactorNumeric" />% of
                </xsl:if>
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cbc:BaseAmount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
            </td>
            <td valign="top" align="right">
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cbc:Amount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>
    <!-- 2) A/C on line level -->
    <xsl:template match="cac:AllowanceCharge" mode="LineLevel-new">
        <xsl:choose>
            <xsl:when test="cbc:ChargeIndicator ='true'">
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BG-28'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BG-27'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="Currency">
            <xsl:with-param name="currencyvalue" select="cbc:Amount" />
            <xsl:with-param name="country" select="$languageCode" />
        </xsl:call-template>
        <small>
            <br />
            <xsl:apply-templates select="cbc:AllowanceChargeReason" />
            [<xsl:apply-templates select="cbc:AllowanceChargeReasonCode" />]
            <xsl:apply-templates select="cbc:MultiplierFactorNumeric" />%
            <br />
        </small>
    </xsl:template>
    <!-- 3) A/C on price unit level (for information only) -->
    <xsl:template match="cac:AllowanceCharge" mode="PriceUnit-new">
        <b>
            <xsl:choose>
                <xsl:when test="cbc:ChargeIndicator ='true'">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-147'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="cbc:ChargeIndicator ='false'">
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-147'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </xsl:when>
            </xsl:choose>
        </b>
        <xsl:choose>
            <xsl:when test="cbc:BaseAmount !='' ">
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cbc:Amount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
                <br />
                <b>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-148'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                </b>
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cbc:BaseAmount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="Currency">
                    <xsl:with-param name="currencyvalue" select="cbc:Amount" />
                    <xsl:with-param name="country" select="$languageCode" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        <br />
    </xsl:template>
    <!-- AllowanceCharge end -->
    <!-- Tax (VAT) totals from here: -->
    <xsl:template match="cac:TaxTotal/cac:TaxSubtotal">
        <div class="tax_table_body_data">
            <xsl:apply-templates select="cac:TaxCategory/cbc:ID" />
            <xsl:call-template name="NumberFormat">
                <xsl:with-param name="value" select="cac:TaxCategory/cbc:Percent" />
                <xsl:with-param name="formatToDecimal" select="'false'" />
                <xsl:with-param name="country" select="$languageCode" />
            </xsl:call-template>
        </div>
        <div class="tax_table_body_data">
            <xsl:choose>
                <xsl:when test="cac:TaxCategory/cbc:Percent !=''">
                &#8201;
                    [<xsl:call-template name="NumberFormat">
                        <xsl:with-param name="value" select="cac:TaxCategory/cbc:Percent" />
                        <xsl:with-param name="formatToDecimal" select="'true'" />
                        <xsl:with-param name="country" select="$languageCode" />
                    </xsl:call-template>%]
                </xsl:when>
                <xsl:otherwise>
                    %
                </xsl:otherwise>
            </xsl:choose>
        </div>
        <div class="tax_table_body_data">
            <xsl:call-template name="Currency">
                <xsl:with-param name="currencyvalue" select="cbc:TaxableAmount" />
                <xsl:with-param name="country" select="$languageCode" />
            </xsl:call-template>
        </div>
        <div class="tax_table_body_data">
            <xsl:call-template name="Currency">
                <xsl:with-param name="currencyvalue" select="cbc:TaxAmount" />
                <xsl:with-param name="country" select="$languageCode" />
            </xsl:call-template>
        </div>
    </xsl:template>
    <xsl:template name="cac:PaymentMeans">
        <xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <b>
                        <small>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-86-1'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </small>
                    </b>
                </div>
                <div class="payment_table_body_data">
                    <small>
                        <xsl:apply-templates select="cac:CardAccount/cbc:NetworkID"/>
                    </small>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID !='' ">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <b>
                        <small>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-86'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </small>
                    </b>
                </div>
                <div class="payment_table_body_data">
                    <small>
                        <xsl:apply-templates select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID"/>&#8201;
                    </small>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID !='' ">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <b>
                        <small>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-86'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </small>
                    </b>
                </div>
                <xsl:choose>
                    <xsl:when test="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID/@schemeID !='' ">
                        <div class="payment_table_body_data">
                            <small>
                                <xsl:apply-templates select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>&#8201;
                                [<xsl:apply-templates select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID/@schemeID"/>]&#8201;
                            </small>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="payment_table_body_data">
                            <small>
                                <xsl:apply-templates select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>&#8201;
                            </small>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </xsl:if>
        <xsl:if test="cac:PaymentMandate/cbc:ID !='' or cac:PaymentMandate/cac:PayerFinancialAccount !=''">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <b>
                        <small>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-91'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </small>
                    </b>
                </div>
                <div class="payment_table_body_data">
                    <small>
                        <xsl:apply-templates select="cac:PaymentMandate/cac:PayerFinancialAccount/cbc:ID"/>
                    </small>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <small>
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-87'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </b>
                    </small>
                </div>
                <div class="payment_table_body_data">
                    <small>
					***
                        <xsl:apply-templates select="cac:CardAccount/cbc:PrimaryAccountNumberID"/>&#8201;
                    </small>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="cac:PayeeFinancialAccount/cbc:ID !=''">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <small>
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-84'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </b>
                    </small>
                </div>
                <div class="payment_table_body_data">
                    <small>
                        <xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''"></xsl:if>
                        <xsl:apply-templates select="cac:PayeeFinancialAccount[1]/cbc:ID"/>&#8201;
                    </small>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="cac:PaymentMandate/cbc:ID !='' or cac:PaymentMandate/cac:PayerFinancialAccount !=''">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <small>
                        <b>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-89'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </b>
                    </small>
                </div>
                <div class="payment_table_body_data">
                    <small>
                        <xsl:apply-templates select="cac:PaymentMandate/cbc:ID"/>
                    </small>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="cac:PaymentMandate != ''">
            <xsl:if test="((../cac:AccountingSupplierParty/cac:PartyIdentification/cbc:ID/@schemeID = 'SEPA') or (../cac:PayeeParty/cac:PartyIdentification/cbc:ID/@schemeID = 'SEPA'))">
                <div class="payment_table_cell">
                    <div class="payment_table_header_title">
                        <b>
                            <small>
                                <xsl:call-template name="LabelName">
                                    <xsl:with-param name="BT-ID" select="'BT-90'"/>
                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                </xsl:call-template>
                            </small>
                        </b>
                    </div>
                    <div class="payment_table_body_data">
                        <small>
                            <xsl:if test="../cac:AccountingSupplierParty/cac:PartyIdentification/cbc:ID/@schemeID = 'SEPA'">
                                <xsl:value-of select="../cac:AccountingSupplierParty/cac:PartyIdentification/cbc:ID" />
                            </xsl:if>
                            <xsl:if test="../cac:PayeeParty/cac:PartyIdentification/cbc:ID/@schemeID = 'SEPA'">
                                <xsl:value-of select="../cac:PayeeParty/cac:PartyIdentification/cbc:ID" />
                            </xsl:if>
                        </small>
                    </div>
                </div>
            </xsl:if>
        </xsl:if>
        <xsl:if test="cac:PayeeFinancialAccount/cbc:Name !=''">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <b>
                        <small>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-85'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </small>
                    </b>
                </div>
                <div class="payment_table_body_data">
                    <small>
                        <xsl:apply-templates select="cac:PayeeFinancialAccount/cbc:Name" />
                    </small>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="not(cac:PaymentMandate) and not(cac:CardAccount) and not(cac:PayeeFinancialAccount)">
            <div class="payment_table_body_data">
                <small></small>
            </div>
        </xsl:if>
        <xsl:if test="cac:CardAccount !=''">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <b>
                        <small>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-88'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </small>
                    </b>
                </div>
                <div class="payment_table_body_data">
                    <small>
                        <xsl:apply-templates select="cac:CardAccount/cbc:HolderName" />
                    </small>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="cbc:PaymentID !=''">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <b>
                        <small>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-83'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </small>
                    </b>
                </div>
                <div class="payment_table_body_data">
                    <small>
                        <xsl:apply-templates select="cbc:PaymentID" />
                    </small>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="((../cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID) or (../cac:PayeeParty/cac:Party/cac:PartyIdentification/cbc:ID !='') or (../cac:AccountingSupplierParty/cac:Party/cbc:EndpointID !='') or (../cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID !='') or (../cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID !=''))">
            <div class="payment_table_cell">
                <div class="payment_table_header_title">
                    <b>
                        <small>
                            <xsl:call-template name="LabelName">
                                <xsl:with-param name="BT-ID" select="'BT-30'"/>
                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                            </xsl:call-template>
                        </small>
                    </b>
                </div>
                <div class="payment_table_body_data">
                    <small>
                        <xsl:choose>
                            <xsl:when test="../cac:PayeeParty !=''">
                                <xsl:choose>
                                    <xsl:when test="../cac:PayeeParty/cac:Party/cac:PartyIdentification/cbc:ID !=''">
                                        <xsl:value-of select="../cac:PayeeParty/cac:Party/cac:PartyIdentification/cbc:ID" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="../cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="../cac:AccountingSupplierParty/cac:Party/cbc:EndpointID !=''">
                                        <xsl:value-of select="../cac:AccountingSupplierParty/cac:Party/cbc:EndpointID" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="../cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID !=''">
                                                <xsl:value-of select="../cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID" />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="../cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </small>
                </div>
            </div>
        </xsl:if>
    </xsl:template>
    <!--PaymentMeans template until here-->
    <!-- PaymentTerms from here: -->
    <xsl:template match="cac:PaymentTerms">
        <xsl:if test="cbc:Note !=''">
            <xsl:apply-templates select="cbc:Note" />
        </xsl:if>
    </xsl:template>
    <!-- Document references from here: -->
    <xsl:template match="cac:AdditionalDocumentReference" mode="InvoicedObject">
        <xsl:if test="cbc:DocumentTypeCode='130'">
            <br />
            <b>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-18'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:value-of select="cbc:ID" />
            <xsl:if test="cbc:ID/@schemeID != ''">
                [<xsl:value-of select="cbc:ID/@schemeID" />]
            </xsl:if>
        </xsl:if>
        <xsl:if test="cbc:DocumentTypeCode='50'">
            <br />
            <b>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-11'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
            </b>
            <xsl:value-of select="cbc:ID" />
            <xsl:if test="cbc:ID/@schemeID != ''">
                [<xsl:value-of select="cbc:ID/@schemeID" />]
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="cac:AdditionalDocumentReference" mode="Supporting">
        <xsl:if test="cbc:ID !=''">
            <br/>
            <p>
                <xsl:call-template name="LabelName">
                    <xsl:with-param name="BT-ID" select="'BT-122'" />
                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                </xsl:call-template>
                <xsl:apply-templates select="cbc:ID" />
                <xsl:if test="cbc:ID/@schemeID != ''">
                    &#8201;[<xsl:apply-templates select="cbc:ID/@schemeID" />]
                </xsl:if>
            </p>
        </xsl:if>
            <xsl:if test="cbc:DocumentType !='' or cbc:DocumentTypeCode !=''">
            <p>
                <small>
                    -&#8201;
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-123'" />
                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                    </xsl:call-template>
                    <xsl:apply-templates select="cbc:DocumentType" />
                    <xsl:if test="cbc:DocumentTypeCode !=''">
                        &#8201;[<xsl:apply-templates select="cbc:DocumentTypeCode" />]
                    </xsl:if>
                </small>
            </p>
        </xsl:if>
        <xsl:if test="cbc:DocumentDescription">
            <small>
                -&#8201;
                <xsl:apply-templates select="cbc:DocumentDescription" />
            </small>
        </xsl:if>
        <p>
            <small>
                <xsl:apply-templates select="cac:Attachment" />
            </small>
        </p>        
    </xsl:template>
    <xsl:template match="cac:Attachment">
        <!-- No processing of attached document, just info: -->
        <xsl:if test="cbc:EmbeddedDocumentBinaryObject/@mimeCode !=''">
            -&#8201;
            <xsl:call-template name="LabelName">
                <xsl:with-param name="BT-ID" select="'BT-125-1'" />
                <xsl:with-param name="Colon-Suffix" select="'true'" />
            </xsl:call-template>
            <xsl:apply-templates select="cbc:EmbeddedDocumentBinaryObject/@mimeCode" />
            <br />
        </xsl:if>
        <xsl:if test="cbc:EmbeddedDocumentBinaryObject/@format !=''">
            -&#8201;
            <xsl:call-template name="LabelName">
                <xsl:with-param name="BT-ID" select="'BT-125-1'" />
                <xsl:with-param name="Colon-Suffix" select="'true'" />
            </xsl:call-template>
            <xsl:apply-templates select="cbc:EmbeddedDocumentBinaryObject/@format" />
            <br />
        </xsl:if>
        <xsl:if test="cbc:EmbeddedDocumentBinaryObject/@filename !=''">
            -&#8201;
            <xsl:call-template name="LabelName">
                <xsl:with-param name="BT-ID" select="'BT-125-2'" />
                <xsl:with-param name="Colon-Suffix" select="'true'" />
            </xsl:call-template>
            <xsl:apply-templates select="cbc:EmbeddedDocumentBinaryObject/@filename" />
            <br />
        </xsl:if>
        <xsl:if test="cbc:EmbeddedDocumentBinaryObject/@mimeCode !=''">
            -&#8201;
            <xsl:call-template name="LabelName">
                <xsl:with-param name="BT-ID" select="'BT-125'" />
                <xsl:with-param name="Colon-Suffix" select="'true'" />
            </xsl:call-template>
            <xsl:choose>
                <xsl:when test="cbc:EmbeddedDocumentBinaryObject/@filename !=''">
                    <a href="data:{cbc:EmbeddedDocumentBinaryObject/@mimeCode};base64,{cbc:EmbeddedDocumentBinaryObject}" download="{cbc:EmbeddedDocumentBinaryObject/@filename}">
                        <xsl:value-of select="cbc:EmbeddedDocumentBinaryObject/@filename"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <a href="data:{cbc:EmbeddedDocumentBinaryObject/@mimeCode};base64,{cbc:EmbeddedDocumentBinaryObject}" download="{../cbc:ID}">
                        <xsl:value-of select="../cbc:ID"/>
                    </a>
                </xsl:otherwise>
            </xsl:choose>
            <br />
        </xsl:if>
        <xsl:if test="cac:ExternalReference !=''">
            -&#8201;
            <xsl:apply-templates select="cac:ExternalReference" />
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="cac:ExternalReference">
        <xsl:if test="cbc:URI !=''">
            <xsl:call-template name="LabelName">
                <xsl:with-param name="BT-ID" select="'BT-124'" />
                <xsl:with-param name="Colon-Suffix" select="'true'" />
            </xsl:call-template>
            <xsl:apply-templates select="cbc:URI" />
        </xsl:if>
    </xsl:template>
    <xsl:template match="cac:BillingReference">
        <br />
        <xsl:if test="cac:CreditNoteDocumentReference !=''">
            <xsl:apply-templates select="cac:CreditNoteDocumentReference/cbc:ID" />&#8201;
        </xsl:if>
        <xsl:if test="cac:InvoiceDocumentReference !=''">
            <xsl:if test="cac:CreditNoteDocumentReference !=''">
                <br />
            </xsl:if>
            <xsl:apply-templates select="cac:InvoiceDocumentReference/cbc:ID" />&#8201;
        </xsl:if>
    </xsl:template>
    <!-- Document references end -->
    <!--Periods from here-->
    <xsl:template match="cac:InvoicePeriod">
        <xsl:if test="cbc:StartDate !=''">
            <xsl:apply-templates select="cbc:StartDate" />&#8201;-&#8201;
        </xsl:if>
        <xsl:if test="cbc:EndDate !='' ">
            <xsl:apply-templates select="cbc:EndDate" />&#8201;
        </xsl:if>
    </xsl:template>
    <!--Periods end-->
</xsl:stylesheet>