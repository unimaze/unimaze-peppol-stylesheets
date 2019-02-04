<?xml version="1.0" encoding="utf-8"?>
<!--
******************************************************************************************************************

		PEPPOL Instance Documentation	

		title= PEPPOL_BIS 4A/5ACommonTemplates.xml	
		publisher= "SFTI tekniska kansli"
		Creator= SFTI/SL
		created= 2014-02-12
		conformsTo= UBL-Invoice-2.1.xsd
		description= "Common templates for displaying PEPPOL BIS 4A/5A, version 2.0 (Invoice and Credit note)"
		
		Derived from work by OIOUBL, Denmark. For more information, see www.sfti.se or email tekniskt.kansli@skl.se
		
******************************************************************************************************************
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fcn="urn:sfti:se:xsl:functions" xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" xmlns:n2="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" xmlns:cdl="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" exclude-result-prefixes="n1 n2 cac cdl cbc ccts sdt udt">
	<xsl:include href="user_config.xsl"/>
	<xsl:variable name="moduleDocBT_en" select="document('Headlines-BT_en.xml')"/>
	<xsl:variable name="moduleDocBT" select="document(concat('Headlines-BT_', $lang, '.xml'))"/>
	<xsl:variable name="invoiceBaseType" select="document(concat('UBLInvoiceBaseType_',$lang, '.xml'))"/>
	<xsl:variable name="UNCL1001" select="document(concat('UNCL1001_', $lang, '.xml'))"/>
	<xsl:variable name="UNCL4461" select="document(concat('UNCL4461_', $lang, '.xml'))"/>
	<xsl:variable name="UNCL7161" select="document(concat('UNCL7161_', $lang, '.xml'))"/>
	<xsl:variable name="UNCL5189" select="document(concat('UNCL5189_', $lang, '.xml'))"/>
	<xsl:variable name="UBLDescriptionCode" select="document(concat('UBLPeriodDescriptionCode_', $lang, '.xml'))"/>
	<xsl:variable name="UBLTaxCategoryCode" select="document(concat('UBLTaxCategoryCode_', $lang, '.xml'))"/>
	<xsl:variable name="UBLClassificationCode" select="document(concat('UBLClassificationCode_', $lang, '.xml'))"/>
	<xsl:variable name="UNECE" select="document(concat('UNECE_', $lang, '.xml'))"/>
	<xsl:variable name="UNCL1001_en" select="document('UNCL1001_en.xml')"/>
	<xsl:variable name="UNCL4461_en" select="document('UNCL4461_en.xml')"/>
	<xsl:variable name="UNCL7161_en" select="document('UNCL7161_en.xml')"/>
	<xsl:variable name="UNCL5189_en" select="document('UNCL5189_en.xml')"/>
	<xsl:variable name="UBLDescriptionCode_en" select="document('UBLPeriodDescriptionCode_en.xml')"/>
	<xsl:variable name="UBLTaxCategoryCode_en" select="document('UBLTaxCategoryCode_en.xml')"/>
	<xsl:variable name="UBLClassificationCode_en" select="document('UBLClassificationCode_en.xml')"/>
	<xsl:variable name="invoiceBaseType_en" select="document('UBLInvoiceBaseType_en.xml')"/>
	<xsl:variable name="UNECE_en" select="document('UNECE_en.xml')"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- En function som i första hand tar DisplayName och i andra hand Business Termför språk istället för i varje xpath -->
	<xsl:function name="fcn:LabelName">
		<xsl:param name="BT-ID"/>
		<!-- BT inparameter -->
		<xsl:param name="Colon-Suffix"/>
		<!-- true/false om kolon ska läggas till efter business term name-->
		<xsl:variable name="LabelVariable" select="if (exists($moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID]/DisplayName)) then ($moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID]/DisplayName) else ($moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID]/TermName)"/>
		<xsl:value-of select="$LabelVariable"/>
		<xsl:if test="$Colon-Suffix ='true' and $LabelVariable != '' ">:&#160;</xsl:if>
	</xsl:function>
	<!--A function to display currencies with spaces as thousand delimiter-->
	<xsl:function name="fcn:Currency">
		<xsl:param name="currencyvalue"/>
		<xsl:variable name="integers" select="substring-before($currencyvalue, '.')"/>
		<xsl:choose>
			<xsl:when test="$integers != ''">
				<xsl:variable name="decimals" select="substring-after($currencyvalue, '.')"/>
				<xsl:variable name="transformedIntegers" select="translate(format-number(number($integers), '#,###'), ',', ' ' )"/>
				<xsl:choose>
					<xsl:when test="$transformedIntegers !='NaN'">
						<xsl:value-of select="concat($transformedIntegers,'.', $decimals)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$currencyvalue"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="transformedIntegers" select="translate(format-number($currencyvalue, '#,###'), ',', ' ' )"/>
			<xsl:choose>
				<xsl:when test="$transformedIntegers !='NaN'">
					<xsl:value-of select="$transformedIntegers"/>
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="$currencyvalue"/>
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:otherwise>
	</xsl:choose>
	
	</xsl:function>
	<xsl:function name="fcn:getGenericCode">
		<xsl:param name="documentName"/>
		<xsl:param name="documentName_en"/>
		<xsl:param name="documentCode"/>	
		<xsl:variable name="genericCodeValue" select="if (exists($documentName/cdl:CodeList/cdl:SimpleCodeList/cdl:Row/cdl:Value/cdl:SimpleValue[../@ColumnRef='name' and ../../cdl:Value[@ColumnRef='code']/cdl:SimpleValue=$documentCode])) then ($documentName/cdl:CodeList/cdl:SimpleCodeList/cdl:Row/cdl:Value/cdl:SimpleValue[../@ColumnRef='name' and ../../cdl:Value[@ColumnRef='code']/cdl:SimpleValue=$documentCode]) else ($documentName_en/cdl:CodeList/cdl:SimpleCodeList/cdl:Row/cdl:Value/cdl:SimpleValue[../@ColumnRef='name' and ../../cdl:Value[@ColumnRef='code']/cdl:SimpleValue=$documentCode])"/>
		
		<xsl:choose>
			<xsl:when test="$genericCodeValue !=''"><xsl:value-of select="$genericCodeValue"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$documentCode"/></xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--Function to pick the Base Type codes for document header--> 
	<xsl:function name="fcn:DocumentHeader">
		<xsl:param name="DocumentCode"/>
		<xsl:value-of select="fcn:getGenericCode($invoiceBaseType, $invoiceBaseType_en, $DocumentCode)"/>
	</xsl:function>
		<!--Function to pick the UNCL1001 codes for document header--> 
	<xsl:function name="fcn:DocumentCode">
		<xsl:param name="DCode"/>
		<xsl:value-of select="fcn:getGenericCode($UNCL1001, $UNCL1001_en, $DCode)"/>
	</xsl:function>
	<xsl:function name="fcn:UBLDescriptionCode">
		<xsl:param name="Code"/>
		<xsl:value-of select="fcn:getGenericCode($UBLDescriptionCode, $UBLDescriptionCode_en, $Code)"/>
	</xsl:function>
	<xsl:function name="fcn:UBLTaxCategoryCode">
		<xsl:param name="Code"/>
		<xsl:value-of select="fcn:getGenericCode($UBLTaxCategoryCode, $UBLTaxCategoryCode_en, $Code)"/>
	</xsl:function>
	<xsl:function name="fcn:UBLClassificationCode">
		<xsl:param name="Code"/>
		<xsl:value-of select="fcn:getGenericCode($UBLClassificationCode, $UBLClassificationCode_en, $Code)"/>
	</xsl:function>
	<!--Function to pick the AllowanceReasonCodes--> 
	<xsl:function name="fcn:AllowanceReasonCode">
		<xsl:param name="AllowanceCode"/>
		<xsl:value-of select="fcn:getGenericCode($UNCL5189, $UNCL5189_en, $AllowanceCode)"/>
	</xsl:function>
	<!--Function to pick the ChargeReasonCodes--> 
	<xsl:function name="fcn:ChargeReasonCode">
		<xsl:param name="ChargeCode"/>
		<xsl:value-of select="fcn:getGenericCode($UNCL7161, $UNCL7161_en, $ChargeCode)"/>
	</xsl:function>
	<!--Function to pick up payment means code-->
	<xsl:function name="fcn:PaymentMeansCode">
		<xsl:param name="PaymentCode"/>
		<xsl:value-of select="fcn:getGenericCode($UNCL4461, $UNCL4461_en, $PaymentCode)"/>
	</xsl:function>
	
		<!--Function to pick the UNECE codes--> 
	<xsl:function name="fcn:UNECECode">
		<xsl:param name="Code"/>
		<xsl:value-of select="fcn:getGenericCode($UNECE, $UNECE_en, $Code)"/>
	</xsl:function>
	
	<xsl:template name="replace">
    <xsl:param name="string"/>
    <xsl:choose>
        <xsl:when test="contains($string,'&#10;')">
            <xsl:value-of select="substring-before($string,'&#10;')"/>
            <br/>
            <xsl:call-template name="replace">
                <xsl:with-param name="string" select="substring-after($string,'&#10;')"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$string"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="cbc:Note">
    <xsl:call-template name="replace">
        <xsl:with-param name="string" select="."/>
    </xsl:call-template>
</xsl:template>
	
	<!--Party templates from here:-->
	<xsl:template match=" cac:AccountingSupplierParty">
		<xsl:call-template name="SellerParty"/>
	</xsl:template>
	<xsl:template match=" cac:AccountingCustomerParty">
		<xsl:call-template name="BuyerParty"/>
	</xsl:template>
	<!--SELLER PARTY STARTS HERE-->
	<xsl:template name="SellerParty">
		<xsl:value-of select="fcn:LabelName('BT-27', 'true')"/>
		<b>
		<xsl:choose>
			<xsl:when test="cac:Party/cac:PartyName !=''">
		<xsl:apply-templates select="cac:Party/cac:PartyName"/>
		</xsl:when>
		<xsl:otherwise>
				<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/>
		</xsl:otherwise>
		</xsl:choose>
		</b>
		<br/><b><xsl:value-of select="fcn:LabelName('BG-5', 'false')"/></b>
		<xsl:call-template name="SellerPostalAddress"/>
		<xsl:for-each select="cac:Party/cac:PartyIdentification">
		<xsl:if test="cbc:ID">
			<br/>
			<small>
				<xsl:value-of select="fcn:LabelName('BT-29', 'true')"/>
				<xsl:apply-templates select="cbc:ID"/>
				<xsl:if test="cbc:ID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cbc:ID/@schemeID"/>]

					</xsl:if>
				&#160;
			</small>
		</xsl:if>
		
		
		
		</xsl:for-each>
		
		<!--Party legal registration: -->
		<xsl:if test="cac:Party/cac:PartyLegalEntity">
			<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:CompanyID">
				<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-30', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID"/>
					<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID"/>]
						
					</xsl:if>
				</small>
			</xsl:if>
			<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
				<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-27', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/>
				</small>
			</xsl:if>
			<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm != ''">
			<small>
						<br/>
						<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm"/>
						</small>
						</xsl:if>
			<xsl:if test="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress !=''">
				<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-33', 'true')"/>
					<xsl:choose>
						<xsl:when test="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !='' and 

							cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
							<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName"/>,&#160;

							<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !=''">
								<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName"/>
							</xsl:if>
							<xsl:if test="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
								<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"/>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</small>
			</xsl:if>
		</xsl:if>
		<!--Party VAT registration: -->
		<xsl:if test="cac:Party/cac:PartyTaxScheme">
			<small>
				<xsl:for-each select="cac:Party/cac:PartyTaxScheme">
					<br/>
					<xsl:choose>
						<xsl:when test="cac:TaxScheme/cbc:ID = 'VAT'">
						<xsl:value-of select="fcn:LabelName('BT-31', 'true')"/>
					<xsl:apply-templates select="cbc:CompanyID"/>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="fcn:LabelName('BT-32', 'true')"/>
					<xsl:apply-templates select="cbc:CompanyID"/> [<xsl:value-of select="cac:TaxScheme/cbc:ID"/>]
					</xsl:otherwise>
					</xsl:choose>
			
					
				
			
				<xsl:if test="cbc:ExemptionReason">
					<br/>

					&#160;<xsl:apply-templates select="cbc:ExemptionReason"/>
				</xsl:if>
				</xsl:for-each>
			</small>

		</xsl:if>
	</xsl:template>
	<xsl:template name="SellerPartyName">
		<xsl:if test="cac:Party/cbc:Name !=''">
			<xsl:apply-templates select="cbc:Name"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="SellerPostalAddress">
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:StreetName !=''">
			<br/>
			<span class="UBLStreetName">
				<xsl:value-of select="fcn:LabelName('BT-35', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:StreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
			<br/>
			<span class="UBLAdditionalStreetName">
				<xsl:value-of select="fcn:LabelName('BT-36', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:AdditionalStreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
			<br/>
			<span class="UBLAdditionalStreetName">
				<xsl:value-of select="fcn:LabelName('BT-162', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:Party/cac:PostalAddress/cbc:CityName !=''">
			<br/>
			<span class="UBLCityName">
				<xsl:choose>
					<xsl:when test="cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
						<xsl:value-of select="fcn:LabelName('BT-38', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:PostalZone"/>&#160;
						<xsl:value-of select="fcn:LabelName('BT-37', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CityName"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="fcn:LabelName('BT-37', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CityName"/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:Party/cac:PostalAddress/cac:Country !=''">
			<xsl:choose>
				<xsl:when test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:Party/cac:PostalAddress/cac:Country !=''">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-39', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CountrySubentity"/><br/>
					<xsl:value-of select="fcn:LabelName('BT-40', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:Country"/>
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<xsl:if test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">
						<xsl:value-of select="fcn:LabelName('BT-39', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CountrySubentity"/>
					</xsl:if>
					<xsl:if test="cac:Party/cac:PostalAddress/cac:Country !=''">
						<xsl:value-of select="fcn:LabelName('BT-40', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="SellerContact">
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ID">
			<small>
				<xsl:value-of select="fcn:LabelName('BT-22', 'true')"/>
				<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ID"/>
			</small>
		</xsl:if>
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name !=''">
			<br/>
			<xsl:value-of select="fcn:LabelName('BT-41', 'true')"/>
			<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name"/>
		</xsl:if>
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone !=''">
			<br/>
			<span class="UBLTelephone">
				<xsl:value-of select="fcn:LabelName('BT-42', 'true')"/>
				<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax !=''">
			<br/>
			<span class="UBLTelefax">
				<xsl:value-of select="fcn:LabelName('BT-22', 'true')"/>
				<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail !=''">
			<br/>
			<span class="UBLElectronicMail">
				<xsl:value-of select="fcn:LabelName('BT-43', 'true')"/>
				<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail"/>
			</span>
		</xsl:if>
	</xsl:template>
	<!--BUYER PARTY STARTS HERE-->
	<xsl:template name="BuyerParty">
		<xsl:value-of select="fcn:LabelName('BT-45', 'true')"/>
		<xsl:choose>
			<xsl:when test="cac:Party/cac:PartyName"><xsl:apply-templates select="cac:Party/cac:PartyName"/></xsl:when>
			<xsl:otherwise><xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/></xsl:otherwise>
		</xsl:choose>
		
		<br/><b><xsl:value-of select="fcn:LabelName('BG-8', 'false')"/></b>
		<xsl:call-template name="BuyerPostalAddress"/>
		
		<xsl:if test="cac:Party/cac:PartyIdentification/cbc:ID">
			<br/>
			<small>
				<b><xsl:value-of select="fcn:LabelName('BT-46', 'true')"/></b>
				<xsl:apply-templates select="cac:Party/cac:PartyIdentification/cbc:ID"/>
				<xsl:if test="cac:Party/cac:PartyIdentification/cbc:ID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyIdentification/cbc:ID/@schemeID"/>]

					</xsl:if>
			</small>
		</xsl:if>
		<!--Party legal registration: -->
		<xsl:if test="cac:Party/cac:PartyLegalEntity">
			<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:CompanyID">
			<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-47', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID"/>
					<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</small>
			</xsl:if>
			<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
			<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-44', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/>
				</small>
			</xsl:if>
		</xsl:if>
		<!--Party VAT registration: -->
		<xsl:if test="cac:Party/cac:PartyTaxScheme">
			<small>
				<xsl:if test="cac:Party/cac:PartyTaxScheme">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-48', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
					<xsl:if test="cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</xsl:if>
				<xsl:if test="cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason">
					<br/><xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason"/>
				</xsl:if>
			</small>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BuyerPartyName">
		<xsl:if test="cac:Party/cbc:Name !=''">
			<xsl:apply-templates select="cbc:Name"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BuyerPostalAddress">
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:StreetName !=''">
			<br/>
			<span class="UBLStreetName">
				<xsl:value-of select="fcn:LabelName('BT-50', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:StreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
			<br/>
			<span class="UBLAdditionalStreetName">
				<xsl:value-of select="fcn:LabelName('BT-51', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:AdditionalStreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
			<br/>
			<span class="UBLAdditionalStreetName">
				<xsl:value-of select="fcn:LabelName('BT-163', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:AddressLine/cbc:Line"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:Party/cac:PostalAddress/cbc:CityName !=''">
			<span class="UBLCityName">
				<xsl:choose>
					<xsl:when test="cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
					<br/>
						<xsl:value-of select="fcn:LabelName('BT-53', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:PostalZone"/> &#160;
						<xsl:value-of select="fcn:LabelName('BT-52', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CityName"/>
					</xsl:when>
					<xsl:otherwise>
					<br/>
						<xsl:value-of select="fcn:LabelName('BT-52', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CityName"/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:Party/cac:PostalAddress/cac:Country !=''">
			<xsl:choose>
				<xsl:when test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:Party/cac:PostalAddress/cac:Country !=''">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-54', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CountrySubentity"/>,
							<xsl:value-of select="fcn:LabelName('BT-55', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:Country"/>
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<xsl:if test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">
						<xsl:value-of select="fcn:LabelName('BT-54', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CountrySubentity"/>
					</xsl:if>
					<xsl:if test="cac:Party/cac:PostalAddress/cac:Country !=''">
						<xsl:value-of select="fcn:LabelName('BT-55', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BuyerContact">
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ID">
			<small>
				<xsl:value-of select="fcn:LabelName('BT-10', 'true')"/>
				<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ID"/>
				<br/>
			</small>
		</xsl:if>
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name !=''">
			<xsl:value-of select="fcn:LabelName('BT-56', 'true')"/>
			<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name"/>
			<br/>
		</xsl:if>
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telephone !=''">
			<span class="UBLTelephone">
				<xsl:value-of select="fcn:LabelName('BT-57', 'true')"/>
				<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telephone"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telefax !=''">
			<span class="UBLTelefax">
				<xsl:value-of select="fcn:LabelName('BT-22', 'true')"/>
				<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telefax"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail !=''">
			<span class="UBLElectronicMail">
				<xsl:value-of select="fcn:LabelName('BT-58', 'true')"/>
				<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail"/>
			</span>
			<br/>
		</xsl:if>
	</xsl:template>
	<!-- PAYEE PARTY STARTS HERE-->
	<xsl:template name="PayeeParty">
		<xsl:value-of select="fcn:LabelName('BT-59', 'true')"/>
		<xsl:apply-templates select="cac:PayeeParty/cac:PartyName"/>
		<xsl:if test="cac:PayeeParty/cac:PartyIdentification/cbc:ID">
			<br/>
			<small>
				<xsl:value-of select="fcn:LabelName('BT-60', 'true')"/>
				<xsl:apply-templates select="cac:PayeeParty/cac:PartyIdentification/cbc:ID"/>
				<xsl:if test="cac:PayeeParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:PayeeParty/cac:PartyIdentification/cbc:ID/@schemeID"/>]

					</xsl:if>
			</small>
		</xsl:if>
		<!--Party legal registration: -->
		<xsl:if test="cac:PayeeParty/cac:PartyLegalEntity">
			<xsl:if test="cac:PayeeParty/cac:PartyLegalEntity">
				<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-61', 'true')"/>
					<xsl:apply-templates select="cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID"/>
					<xsl:if test="cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</small>
			</xsl:if>
		</xsl:if>
		<!--Party VAT registration: -->
		<xsl:if test="cac:PayeeParty/cac:PartyTaxScheme">
			<small>
				<xsl:if test="cac:PayeeParty/cac:PartyTaxScheme">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-63', 'true')"/>
					<xsl:apply-templates select="cac:PayeeParty/cac:PartyTaxScheme/cbc:CompanyID"/>
					<xsl:if test="cac:PayeeParty/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:PayeeParty/cac:PartyTaxScheme/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</xsl:if>
			</small>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PayeePartyName">
		<xsl:if test="cac:PayeeParty/cbc:Name !=''">
			<xsl:apply-templates select="cbc:Name"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:PartyName">
		<xsl:if test="cbc:Name !=''">
			<xsl:apply-templates select="cbc:Name"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:PostalAddress | cac:DeliveryAddress | cac:Address ">
		<xsl:if test="cbc:StreetName !=''">
			<br/>
			<span class="UBLStreetName">
				<xsl:apply-templates select="cbc:StreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cbc:AdditionalStreetName !=''">
			<br/>
			<span class="UBLAdditionalStreetName">
				<xsl:apply-templates select="cbc:AdditionalStreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:AddressLine/cbc:Line !=''">
			<br/>
			<span class="UBLAdditionalStreetName">
				<xsl:apply-templates select="cac:AddressLine/cbc:Line"/>
			</span>
		</xsl:if>
		<xsl:if test="cbc:PostalZone !='' or cbc:CityName !=''">
			<br/>
			<span class="UBLCityName">
				<xsl:choose>
					<xsl:when test="cbc:PostalZone !=''">
						<xsl:apply-templates select="cbc:PostalZone"/>&#160;
						<xsl:apply-templates select="cbc:CityName"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="cbc:CityName"/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</xsl:if>
		<xsl:if test="cbc:CountrySubentity !='' or cac:Country !=''">
			<xsl:choose>
				<xsl:when test="cbc:CountrySubentity !='' and cac:Country !=''">
					<br/>
					<xsl:apply-templates select="cbc:CountrySubentity"/>,
							<xsl:apply-templates select="cac:Country"/>
							<br/>
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<xsl:if test="cbc:CountrySubentity !=''">
						<xsl:apply-templates select="cbc:CountrySubentity"/>
					</xsl:if>
					<xsl:if test="cac:Country !=''">
						<xsl:apply-templates select="cac:Country/cbc:IdentificationCode"/>
					</xsl:if>
					<br/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:Country">
		<span>
			<xsl:apply-templates select="cbc:IdentificationCode"/>
			<!-- Checking of listID (normally NOT a function of a stylesheet): -->
			<xsl:if test="cbc:IdentificationCode/@listID !=''">
				<xsl:if test="cbc:IdentificationCode/@listID !='ISO3166-1:Alpha2'">

					&#160;<small>
						<em>[<xsl:apply-templates select="cbc:IdentificationCode/@listID"/>
					&#160;-invalid listID]</em>
					</small>
				</xsl:if>
			</xsl:if>
		</span>
	</xsl:template>
	
	<!--TaxRepresentativeParty Starts here:-->
	<xsl:template match="cac:TaxRepresentativeParty">
	<xsl:if test="cac:PartyName/cbc:Name !=''">
			<xsl:value-of select="cac:PartyName/cbc:Name"/><br/>
	</xsl:if>
	<xsl:if test="cac:PostalAddress/cbc:StreetName !=''">
			
				<xsl:apply-templates select="cac:PostalAddress/cbc:StreetName"/><br/>
		</xsl:if>
		<xsl:if test="cac:PostalAddress/cbc:AdditionalStreetName !=''">
				<xsl:apply-templates select="cac:PostalAddress/cbc:AdditionalStreetName"/><br/>
		</xsl:if>
		<xsl:if test="cac:PostalAddress/cac:AddressLine/cbc:Line !=''">
				<xsl:apply-templates select="cac:PostalAddress/cac:AddressLine/cbc:Line"/>	<br/>
		</xsl:if>
		<xsl:if test="cac:PostalAddress/cbc:PostalZone !='' or cac:PostalAddress/cbc:CityName !=''">
				<xsl:choose>
					<xsl:when test="cac:PostalAddress/cbc:PostalZone !=''">
						<xsl:apply-templates select="cac:PostalAddress/cbc:PostalZone"/>&#160;
						<xsl:apply-templates select="cac:PostalAddress/cbc:CityName"/><br/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="cac:PostalAddress/cbc:CityName"/><br/>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:if>
		<xsl:if test="cac:PostalAddress/cbc:CountrySubentity !='' or cac:PostalAddress/cac:Country !=''">
			<xsl:choose>
				<xsl:when test="cac:PostalAddress/cbc:CountrySubentity !='' and cac:PostalAddress/cac:Country !=''">
					<xsl:apply-templates select="cac:PostalAddress/cbc:CountrySubentity"/>,
							<xsl:apply-templates select="cac:PostalAddress/cac:Country"/>
							<br/>
				</xsl:when>
				<xsl:otherwise>
				
					<xsl:if test="cac:PostalAddress/cbc:CountrySubentity !=''">
						<xsl:apply-templates select="cac:PostalAddress/cbc:CountrySubentity"/>	<br/>
					</xsl:if>
					<xsl:if test="cac:PostalAddress/cac:Country !=''">
						<xsl:apply-templates select="cac:PostalAddress/cac:Country/cbc:IdentificationCode"/><br/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="cac:PartyTaxScheme/cbc:CompanyID !=''">
		<small>
		<xsl:value-of select="fcn:LabelName('BT-63', 'true')"/>
		<xsl:value-of select="cac:PartyTaxScheme/cbc:CompanyID"/>
		</small>
		</xsl:if>
	
	
	
	</xsl:template>
	<!--Delivery templates start: -->
	<xsl:template match="cac:Delivery" mode="DocumentHeader">
		<p>
		
			<xsl:if test="cac:DeliveryLocation !=''">
				<b>
					<xsl:value-of select="fcn:LabelName('BG-13', 'false')"/>
					<br/>
				</b>
				<xsl:if test="cac:DeliveryParty/cac:PartyName/cbc:Name != ''">
		<xsl:apply-templates select="cac:DeliveryParty/cac:PartyName/cbc:Name"/><br/>
		
		</xsl:if>
				<xsl:apply-templates select="cac:DeliveryLocation"/>
			</xsl:if>
		</p>
	</xsl:template>
	<xsl:template match="cac:DeliveryLocation">
		<xsl:if test="cbc:ID !=''">
			<xsl:value-of select="fcn:LabelName('BT-71', 'true')"/>
			<xsl:apply-templates select="cbc:ID"/>
			<xsl:choose>
				<xsl:when test="cbc:ID/@schemeID !=''">
							&#160;[<xsl:apply-templates select="cbc:ID/@schemeID"/>]
						</xsl:when>
				<xsl:otherwise>
							&#160;[No schemeID]
						</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="cac:Address !=''">
		<br/>
			<xsl:call-template name="DeliveryAddress"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="DeliveryAddress">
	<b><xsl:value-of select="fcn:LabelName('BG-15', 'false')"/></b>
		<xsl:if test="cac:Address/cbc:StreetName !=''">
			<span class="UBLStreetName">
				<br/><xsl:value-of select="fcn:LabelName('BT-75', 'true')"/>
				<xsl:apply-templates select="cac:Address/cbc:StreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Address/cbc:AdditionalStreetName !=''">
			<span class="UBLAdditionalStreetName">
				<br/><xsl:value-of select="fcn:LabelName('BT-76', 'true')"/>
				<xsl:apply-templates select="cac:Address/cbc:AdditionalStreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Address/cac:AddressLine/cbc:Line !=''">
			<span class="UBLAdditionalStreetName">
				<br/><xsl:value-of select="fcn:LabelName('BT-165', 'true')"/>
				<xsl:apply-templates select="cac:Address/cac:AddressLine/cbc:Line"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Address/cbc:PostalZone !='' or cac:Address/cbc:CityName !=''">
			<br/>
			<span class="UBLCityName">
				<xsl:choose>
					<xsl:when test="cac:Address/cbc:PostalZone !=''">
						<xsl:value-of select="fcn:LabelName('BT-78', 'true')"/>
						<xsl:apply-templates select="cac:Address/cbc:PostalZone"/>&#160;
						<xsl:value-of select="fcn:LabelName('BT-77', 'true')"/>
						<xsl:apply-templates select="cac:Address/cbc:CityName"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="fcn:LabelName('BT-77', 'true')"/>
						<xsl:apply-templates select="cac:Address/cbc:CityName"/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</xsl:if>
		<xsl:if test="cac:Address/cbc:CountrySubentity !='' or cac:Address/cac:Country !=''">
			<xsl:choose>
				<xsl:when test="cac:Address/cbc:CountrySubentity !='' and cac:Address/cac:Country !=''">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-79', 'true')"/>
					<xsl:apply-templates select="cac:Address/cbc:CountrySubentity"/>,
							
							<xsl:value-of select="fcn:LabelName('BT-80', 'true')"/>
					<xsl:apply-templates select="cac:Address/cac:Country"/>
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<xsl:if test="cac:Address/cbc:CountrySubentity !=''">
						<xsl:value-of select="fcn:LabelName('BT-79', 'true')"/>
						<xsl:apply-templates select="cac:Address/cbc:CountrySubentity"/>
					</xsl:if>
					<xsl:if test="cac:Address/cac:Country !=''">
						<xsl:value-of select="fcn:LabelName('BT-80', 'true')"/>
						<xsl:apply-templates select="cac:Address/cac:Country/cbc:IdentificationCode"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!--Contact from here: -->
	<xsl:template match="cac:AccountingSupplierParty/cac:Party" mode="accsupcontact">
		<xsl:apply-templates select="cac:Contact"/>
	</xsl:template>
	<xsl:template match="cac:AccountingCustomerParty/cac:Party" mode="acccuscontact">
		<xsl:apply-templates select="cac:Contact"/>
	</xsl:template>
	<!--Invoiceline start: -->
	<xsl:template match="cac:InvoiceLine | cac:CreditNoteLine">
		<tr>
			<td>
				<xsl:apply-templates select="cbc:ID"/>
			</td>
			<td>
				<xsl:apply-templates select="cac:Item/cac:SellersItemIdentification"/>
			</td>
			<td>
				<xsl:apply-templates select="cac:Item/cbc:Name"/>
				<br/><br/>
				<small>
					<xsl:if test="cac:Item/cac:StandardItemIdentification/cbc:ID !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-157', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:Item/cac:StandardItemIdentification/cbc:ID"/>
						<xsl:choose>
							<xsl:when test="cac:Item/cac:StandardItemIdentification/cbc:ID/@schemeID !=''">
								<small>&#160;[<xsl:apply-templates select="cac:Item/cac:StandardItemIdentification/cbc:ID/@schemeID"/>]</small>
							</xsl:when>
							<xsl:otherwise>
								<small>&#160;[No schemeID]</small>
							</xsl:otherwise>
						</xsl:choose>
						<br/>
					</xsl:if>
					<xsl:if test="cac:Item/cbc:Description !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-154', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:Item/cbc:Description"/>
						<br/>
					</xsl:if>
					<xsl:if test="cac:Item/cac:AdditionalItemProperty !=''">
						<xsl:apply-templates select="cac:Item/cac:AdditionalItemProperty"/>
					</xsl:if>
					<xsl:if test="cbc:Note !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-127', 'true')"/>
						</b>
						<xsl:apply-templates select="cbc:Note"/>
						<br/>
					</xsl:if>
					<xsl:if test="cac:Item/cac:CommodityClassification !=''">
						<xsl:apply-templates select="cac:Item/cac:CommodityClassification"/>
					</xsl:if>
					<xsl:if test="cac:Item/cac:BuyersItemIdentification/cbc:ID != ''">
					<b>
							<xsl:value-of select="fcn:LabelName('BT-156', 'true')"/>
						</b>
					<xsl:apply-templates select="cac:Item/cac:BuyersItemIdentification/cbc:ID"/>
					<br/>
					</xsl:if>
					<xsl:if test="cbc:AccountingCost !=''">
						<b>
						<xsl:value-of select="fcn:LabelName('BT-19', 'true')"/>
						</b>
					<xsl:apply-templates select="cbc:AccountingCost"/>
						<br/>
					</xsl:if>
					<xsl:if test="cac:InvoicePeriod !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BG-14', 'true')"/>
						</b>
					<xsl:apply-templates select="cac:InvoicePeriod"/>
						<br/>
					</xsl:if>
					<xsl:if test="cac:Price/cac:AllowanceCharge !=''">
					
						<xsl:apply-templates select="cac:Price/cac:AllowanceCharge" mode="PriceUnit-new"/>
					</xsl:if>
					<xsl:if test="cac:Item/cac:OriginCountry/cbc:IdentificationCode !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-159', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:Item/cac:OriginCountry/cbc:IdentificationCode"/>
						<xsl:if test="cac:Item/cac:OriginCountry/cbc:IdentificationCode/@listID !=''">
							<small>&#160;[<xsl:apply-templates select="cac:Item/cac:OriginCountry/cbc:IdentificationCode/@listID"/>]</small>
						</xsl:if>
						<br/>
					</xsl:if>
					<xsl:if test="cac:OrderLineReference/cbc:LineID !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-132', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:OrderLineReference/cbc:LineID"/>
						<br/>
					</xsl:if>
					<xsl:if test="cac:DocumentReference/cbc:ID !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-128', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:DocumentReference/cbc:ID"/> [<xsl:apply-templates select="cac:DocumentReference/cbc:ID/@schemeID"/>]
						<br/>
					</xsl:if>
				</small>
			</td>
			<td align="left">
				<xsl:if test="cbc:InvoicedQuantity !=''">
					<xsl:apply-templates select="cbc:InvoicedQuantity"/>&#160;
					<xsl:if test="cbc:InvoicedQuantity/@unitCode !=''">
						<xsl:value-of select="cbc:InvoicedQuantity/@unitCode"/>
						<br/>
						<small>(<xsl:value-of select="fcn:LabelName('BT-130', 'true')"/><xsl:value-of select="fcn:UNECECode(cbc:InvoicedQuantity/@unitCode)"/>)</small>
					</xsl:if>
				</xsl:if>
				<xsl:if test="cbc:CreditedQuantity !=''">
					<xsl:apply-templates select="cbc:CreditedQuantity"/>&#160;
					<xsl:if test="cbc:CreditedQuantity/@unitCode !=''">
						<xsl:value-of select="cbc:CreditedQuantity/@unitCode"/>
						<br/>
						<small>(<xsl:value-of select="fcn:LabelName('BT-130', 'true')"/><xsl:value-of select="fcn:UNECECode(cbc:CreditedQuantity/@unitCode)"/>)</small>
					</xsl:if>
				</xsl:if>
			</td>
		
			<td>
				<xsl:apply-templates select="cac:Price"/>
				<xsl:if test="cac:Price/cbc:BaseQuantity">
					<small>
						<br/>
						<b>
							<xsl:value-of select="fcn:LabelName('BT-149', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:Price/cbc:BaseQuantity"/>
					</small>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="cac:Item/cac:ClassifiedTaxCategory !='' ">
					<xsl:choose>
						<xsl:when test="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent !=''">

							<xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cbc:ID"/>,&#160;

							
							<xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent"/>%

						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;
							<xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cbc:ID"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="cac:TaxTotal/cbc:TaxAmount">
					<small>
						<xsl:choose>
							<xsl:when test="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent !=''">
								<br/>(<xsl:apply-templates select="fcn:Currency(cac:TaxTotal/cbc:TaxAmount)"/>)

						</xsl:when>
							<xsl:otherwise>
							(<xsl:apply-templates select="fcn:Currency(cac:TaxTotal/cbc:TaxAmount)"/>)

						</xsl:otherwise>
						</xsl:choose>
					</small>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="cac:AllowanceCharge !=''">
					<xsl:apply-templates select="cac:AllowanceCharge" mode="LineLevel-new"/>
				</xsl:if>
			</td>
			<td align="right">
				<xsl:apply-templates select="fcn:Currency(cbc:LineExtensionAmount)"/>
			</td>
		</tr>
		<!-- Invoice line/part 3: -->
		<xsl:if test="cac:Delivery !=''">
			<tr>
				<td>
				</td>
				<td>
				</td>
				<td class="UBLName">
					<table border="0" width="90%" cellspacing="0" cellpadding="2">
						<xsl:apply-templates select="cac:Delivery" mode="line-new"/>
					</table>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:CommodityClassification">
		<xsl:if test="cbc:CommodityCode !=''">
			<b>
				<xsl:value-of select="fcn:LabelName('BT-158', 'true')"/>
			</b>
			<xsl:apply-templates select="cbc:CommodityCode"/>
			<xsl:choose>
				<xsl:when test="cbc:CommodityCode/@listID !=''">
					<small>&#160;[<xsl:value-of select="fcn:UBLClassificationCode(cbc:CommodityCode/@listID)"/>]</small>
				</xsl:when>
				<xsl:otherwise>
					<small>&#160;[No listID]</small>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="cbc:CommodityCode/@listVersionID !=''">
				 [<xsl:apply-templates select="cbc:CommodityCode/@listeVersionID"/>]
			</xsl:if>
			<br/>
		</xsl:if>
		<xsl:if test="cbc:ItemClassificationCode !=''">
			<b>
				<xsl:value-of select="fcn:LabelName('BT-158', 'true')"/>
			</b>
			<xsl:apply-templates select="cbc:ItemClassificationCode"/>
			<xsl:choose>
				<xsl:when test="cbc:ItemClassificationCode/@listID !=''">
					<small>&#160;[<xsl:value-of select="fcn:UBLClassificationCode(cbc:ItemClassificationCode/@listID)"/>]</small>
				</xsl:when>
				<xsl:otherwise>
					<small>&#160;[No listID]</small>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="cbc:ItemClassificationCode/@listVersionID !=''">
				 [<xsl:apply-templates select="cbc:ItemClassificationCode/@listVersionID"/>]
			</xsl:if>
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:AdditionalItemProperty">
		<b>
			<xsl:value-of select="fcn:LabelName('BT-160', 'true')"/>
		</b>
		<xsl:apply-templates select="cbc:Name"/> = 
		<xsl:apply-templates select="cbc:Value"/>
		<br/>
	</xsl:template>
	<xsl:template match="cac:SellersItemIdentification">
		<xsl:apply-templates select="cbc:ID"/>
	</xsl:template>
	<xsl:template match="cac:Price">
		<xsl:apply-templates select="fcn:Currency(cbc:PriceAmount)"/>&#160;<xsl:apply-templates select="cbc:PriceAmount/@currencyID"/>
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
						<xsl:value-of select="fcn:LabelName('BG-21', 'true')"/>
					</xsl:when>
					<xsl:when test="cbc:ChargeIndicator ='false'">
						<xsl:value-of select="fcn:LabelName('BG-20', 'true')"/>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</td>
			<td valign="top" colspan="2">
				<xsl:if test="cbc:AllowanceChargeReasonCode !=''">
					<xsl:apply-templates select="cbc:AllowanceChargeReasonCode"/>
				</xsl:if>
			</td>
			<td valign="top" colspan="2">
				<xsl:apply-templates select="cbc:AllowanceChargeReason"/>
			</td>
			<td>
				<xsl:if test="cac:TaxCategory !='' ">
					<xsl:choose>
						<xsl:when test="cac:TaxCategory/cbc:Percent !=''">
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>,
							&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:Percent"/>%

						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>
			<td valign="top" align="right">
				<xsl:apply-templates select="fcn:Currency(cbc:Amount)"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="Allowance">
		<tr>
			<td valign="top" colspan="2">
				
					<xsl:apply-templates select="cbc:AllowanceChargeReasonCode"/>
					<!--xsl:value-of select="fcn:AllowanceReasonCode(cbc:AllowanceChargeReasonCode)"/-->
				
			</td>
			<td valign="top" colspan="2">
				<xsl:apply-templates select="cbc:AllowanceChargeReason"/>
			</td>
			<td>
				<xsl:if test="cac:TaxCategory !='' ">
					<xsl:choose>
						<xsl:when test="cac:TaxCategory/cbc:Percent !=''">
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>,
							&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:Percent"/>%

						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				
			</td>
			<td valign="top" align="right">
			<xsl:if test="cbc:MultiplierFactorNumeric != ''">
				<xsl:apply-templates select="cbc:MultiplierFactorNumeric"/>% of 
				</xsl:if>
				<xsl:apply-templates select="fcn:Currency(cbc:BaseAmount)"/>
			</td>
			<td valign="top" align="right">
				<xsl:apply-templates select="fcn:Currency(cbc:Amount)"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="Charge">
						
			<tr>
			<td valign="top" colspan="2">
			<xsl:apply-templates select="cbc:AllowanceChargeReasonCode"/>
			</td>
			<td valign="top" colspan="2">
				<xsl:apply-templates select="cbc:AllowanceChargeReason"/>
			</td>
			<td>
				<xsl:if test="cac:TaxCategory !='' ">
					<xsl:choose>
						<xsl:when test="cac:TaxCategory/cbc:Percent !=''">
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>,
							&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:Percent"/>%

						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				
			</td>
			<td valign="top" align="right">
			<xsl:if test="cbc:MultiplierFactorNumeric != ''">
				<xsl:apply-templates select="cbc:MultiplierFactorNumeric"/>% of 
				</xsl:if>
				<xsl:apply-templates select="fcn:Currency(cbc:BaseAmount)"/>
			</td>
			<td valign="top" align="right">
				<xsl:apply-templates select="fcn:Currency(cbc:Amount)"/>
			</td>
		</tr>
	</xsl:template>
	
	<!-- 2) A/C on line level -->
	<xsl:template match="cac:AllowanceCharge" mode="LineLevel-new">
	
	<xsl:choose>
		<xsl:when test="cbc:ChargeIndicator ='true'">
				<xsl:value-of select="fcn:LabelName('BG-28', 'true')"/>
			</xsl:when>
			<xsl:otherwise>
			<xsl:value-of select="fcn:LabelName('BG-27', 'true')"/>			</xsl:otherwise>
	</xsl:choose>
		<xsl:apply-templates select="fcn:Currency(cbc:Amount)"/>
		<small>
			<br/>
			<xsl:apply-templates select="cbc:AllowanceChargeReason"/> (<xsl:apply-templates select="cbc:AllowanceChargeReasonCode"/>) 
			<xsl:apply-templates select="cbc:MultiplierFactorNumeric"/>%
			<br/>
	
		</small>
		
	</xsl:template>
	<!-- 3) A/C on price unit level (for information only) -->
	<xsl:template match="cac:AllowanceCharge" mode="PriceUnit-new">
	<b>
		<xsl:choose>
			<xsl:when test="cbc:ChargeIndicator ='true'">
			<xsl:value-of select="fcn:LabelName('BT-147', 'true')"/>
			</xsl:when>
			<xsl:when test="cbc:ChargeIndicator ='false'">
			<xsl:value-of select="fcn:LabelName('BT-147', 'true')"/>
			</xsl:when>
		</xsl:choose>
		</b>
		<xsl:choose>
			<xsl:when test="cbc:BaseAmount !='' ">
				<xsl:apply-templates select="fcn:Currency(cbc:Amount)"/>
				<br/><b><xsl:value-of select="fcn:LabelName('BT-148', 'true')"/></b>

				<xsl:apply-templates select="fcn:Currency(cbc:BaseAmount)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="fcn:Currency(cbc:Amount)"/>
			</xsl:otherwise>
		</xsl:choose>
		<br/>
	</xsl:template>
	<!-- AllowanceCharge end -->
	<!-- Tax (VAT) totals from here: -->
	<xsl:template match="cac:TaxTotal/cac:TaxSubtotal">
		<tr class="TAXInformation">
			<td colspan="2">
				<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>
				:&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>&#160;
				<small>(<xsl:value-of select="fcn:UBLTaxCategoryCode(cac:TaxCategory/cbc:ID)"/>),</small>
				<xsl:choose>
					<xsl:when test="cac:TaxCategory/cbc:Percent !=''">
						&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:Percent"/>%
					</xsl:when>
					<xsl:otherwise>
						%
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td colspan="2">
				<xsl:if test="cac:TaxCategory/cbc:TaxExemptionReason !=''">
					<xsl:apply-templates select="cac:TaxCategory/cbc:TaxExemptionReason"/> [<xsl:apply-templates select="cac:TaxCategory/cbc:TaxExemptionReasonCode"/>]
				</xsl:if>
			</td>
			<td colspan="2">
				<xsl:apply-templates select="fcn:Currency(cbc:TaxableAmount)"/>
			</td>
			<td align="right">
				<xsl:apply-templates select="fcn:Currency(cbc:TaxAmount)"/>
			</td>
		</tr>
	</xsl:template>
	<!--TaxTotal until here-->
	<!--PaymentMeans from here-->
	
	<xsl:template name="cac:PaymentMeans">
		<tr>
			<td valign="top">
			<xsl:apply-templates select="cbc:PaymentMeansCode"/>
			<smaller> (<xsl:choose>	
		<xsl:when test="cbc:PaymentMeansCode/@name != ''">
			<xsl:apply-templates select="cbc:PaymentMeansCode/@name"/>
			</xsl:when>
			<xsl:otherwise>
					<xsl:value-of select="fcn:PaymentMeansCode(cbc:PaymentMeansCode)"/>
			</xsl:otherwise>
			</xsl:choose>) 
			</smaller>
			</td>
			<td valign="top" colspan="2">
				<xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
					<xsl:apply-templates select="cac:CardAccount/cbc:NetworkID"/>
				</xsl:if>
				<xsl:if test="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID">
					<xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
						<br/>
					</xsl:if>
					<xsl:apply-templates select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>&#160;
				</xsl:if>
				<xsl:if test="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID !='' ">
						<xsl:apply-templates select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID"/>&#160;
					</xsl:if>
					<xsl:if test="cac:PaymentMandate/cbc:ID !='' or cac:PaymentMandate/cac:PayerFinancialAccount !=''">
				<xsl:apply-templates select="cac:PaymentMandate/cac:PayerFinancialAccount/cbc:ID"/>
				
				</xsl:if>
			</td>
			<td valign="top" colspan="2">
				<xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
					***<xsl:apply-templates select="cac:CardAccount/cbc:PrimaryAccountNumberID"/>&#160;
				</xsl:if>
				<xsl:if test="cac:PayeeFinancialAccount/cbc:ID !='' or 
							cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID !=''">
					<xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
					</xsl:if>
					<xsl:apply-templates select="cac:PayeeFinancialAccount/cbc:ID"/>&#160;
						
				</xsl:if>
				<xsl:if test="cac:PaymentMandate/cbc:ID !='' or cac:PaymentMandate/cac:PayerFinancialAccount !=''">
				<xsl:apply-templates select="cac:PaymentMandate/cbc:ID"/>
				
				</xsl:if>
			</td>
			<xsl:if test="cac:PaymentMandate != ''">
				<td valign="top" colspan="2">
					<xsl:if test="../cac:AccountingSupplierParty/cac:PartyIdentification/cbc:ID/@schemeID = 'SEPA'">
						<xsl:value-of select="../cac:AccountingSupplierParty/cac:PartyIdentification/cbc:ID"/>
					</xsl:if>
					<xsl:if test="../cac:PayeeParty/cac:PartyIdentification/cbc:ID/@schemeID = 'SEPA'">
						<xsl:value-of select="../cac:PayeeParty/cac:PartyIdentification/cbc:ID"/>
					</xsl:if>
				</td>
			</xsl:if>
			<xsl:if test="cac:PayeeFinancialAccount !=''">
					
				<td valign="top" colspan="2">
					<xsl:apply-templates select="cac:PayeeFinancialAccount/cbc:Name"/>
				</td>
			</xsl:if>
			<xsl:if test="not(cac:PaymentMandate) and not(cac:CardAccount) and not(cac:PayeeFinancialAccount)">
			<td valign="top" colspan="2">
			</td>
			</xsl:if>
			<xsl:if test="cac:CardAccount !=''">
			<td valign="top" colspan="2">
					<xsl:apply-templates select="cac:CardAccount/cbc:HolderName"/>
					
			</td>
			</xsl:if>
			
			<td valign="top" align="right">
				<xsl:if test="cbc:PaymentID !=''">
					<xsl:apply-templates select="cbc:PaymentID"/>
				</xsl:if>
			</td>
			<!--td valign="top" align="right">
			
			</td-->
		</tr>
	</xsl:template>
	<!--PaymentMeans template until here-->
	<!-- PaymentTerms from here: -->
	<xsl:template match="cac:PaymentTerms">
		<xsl:if test="cbc:Note !=''">
					<xsl:apply-templates select="cbc:Note"/>
					
		
		</xsl:if>
		
	</xsl:template>
	<!-- Document references from here: -->
	
		<xsl:template match="cac:AdditionalDocumentReference" mode="InvoicedObject">

									<xsl:if test="cbc:DocumentTypeCode='130'">
										<br/>
										<b>
											<xsl:value-of select="fcn:LabelName('BT-18', 'true')"/>
										</b>
										<xsl:value-of select="cbc:ID"/>
										<xsl:if test="cbc:ID/@schemeID != ''"> [<xsl:value-of select="cbc:ID/@schemeID"/>]</xsl:if>
										
									</xsl:if>
									<xsl:if test="cbc:DocumentTypeCode='50'">
										<br/>
										<b>
											<xsl:value-of select="fcn:LabelName('BT-11', 'true')"/>
										</b>
										<xsl:value-of select="cbc:ID"/>
										<xsl:if test="cbc:ID/@schemeID != ''"> [<xsl:value-of select="cbc:ID/@schemeID"/>]</xsl:if>
									</xsl:if>

		</xsl:template>

	<xsl:template match="cac:AdditionalDocumentReference" mode="Supporting">
	
	<xsl:if test="cbc:ID !=''">
			
				<xsl:value-of select="fcn:LabelName('BT-122', 'true')"/><xsl:apply-templates select="cbc:ID"/>
				<xsl:if test="cbc:ID/@schemeID != ''"> [<xsl:apply-templates select="cbc:ID/@schemeID"/>]</xsl:if>
				
				
	</xsl:if>
	<small>
	<xsl:if test="cbc:DocumentType !='' or cbc:DocumentTypeCode !=''">
			<br/>
			-&#160;<xsl:value-of select="fcn:LabelName('BT-123', 'true')"/> <xsl:apply-templates select="cbc:DocumentType"/>&#160;[<xsl:apply-templates select="cbc:DocumentTypeCode"/>]
		</xsl:if>	
		<xsl:if test="cbc:DocumentDescription">	
			-&#160;<xsl:apply-templates select="cbc:DocumentDescription"/>	
		</xsl:if>
		
		<br/>
			<xsl:apply-templates select="cac:Attachment"/>
		</small>
	</xsl:template>
	<xsl:template match="cac:Attachment">
		<!-- No processing of attached document, just info: -->
		<xsl:if test="cbc:EmbeddedDocumentBinaryObject/@mimeCode !=''">
				-&#160;<xsl:value-of select="fcn:LabelName('BT-125-1', 'true')"/><xsl:apply-templates select="cbc:EmbeddedDocumentBinaryObject/@mimeCode"/>
				<br/>
		</xsl:if>
		<xsl:if test="cbc:EmbeddedDocumentBinaryObject/@format !=''">
				-&#160;<xsl:value-of select="fcn:LabelName('BT-125-1', 'true')"/><xsl:apply-templates select="cbc:EmbeddedDocumentBinaryObject/@format"/>
				<br/>
		</xsl:if>
		<xsl:if test="cbc:EmbeddedDocumentBinaryObject/@filename !=''">
				-&#160;<xsl:value-of select="fcn:LabelName('BT-125-2', 'true')"/><xsl:apply-templates select="cbc:EmbeddedDocumentBinaryObject/@filename"/>
				<br/>
		</xsl:if>
		<xsl:if test="cac:ExternalReference !=''">
			-&#160;<xsl:apply-templates select="cac:ExternalReference"/>
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:ExternalReference">
		<xsl:if test="cbc:URI !=''">
			<xsl:value-of select="fcn:LabelName('BT-124', 'true')"/>
			<xsl:apply-templates select="cbc:URI"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:BillingReference">
		<br/>
		<xsl:if test="cac:CreditNoteDocumentReference !=''">
					<xsl:apply-templates select="cac:CreditNoteDocumentReference/cbc:ID"/>&#160;
				</xsl:if>
		<xsl:if test="cac:InvoiceDocumentReference !=''">
			<xsl:if test="cac:CreditNoteDocumentReference !=''">
				<br/>
			</xsl:if>
					<xsl:apply-templates select="cac:InvoiceDocumentReference/cbc:ID"/>&#160;
				</xsl:if>
	</xsl:template>
	<!-- Document references end -->
	<!--Periods from here-->
	<xsl:template match="cac:InvoicePeriod">
		<xsl:if test="cbc:StartDate !=''">
			<xsl:apply-templates select="cbc:StartDate"/>&#160;-&#160;
		</xsl:if>
		<xsl:if test="cbc:EndDate !='' ">
		<xsl:apply-templates select="cbc:EndDate"/>&#160;
		</xsl:if>
	</xsl:template>
	<!--Periods end-->
</xsl:stylesheet>
