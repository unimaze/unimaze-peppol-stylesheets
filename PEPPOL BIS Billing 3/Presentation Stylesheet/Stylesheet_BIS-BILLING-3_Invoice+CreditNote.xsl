<?xml version="1.0" encoding="UTF-8"?>
<!--
******************************************************************************************************************

		PEPPOLInstance Documentation - reference stylesheet 	Version of this reference stylesheet: 1.0 [also c.f. Headlines.xml, TechFooter3]

		title= PEPPOL_BIS_HTML Stylesheet_2014.xsl	
		publisher= "SFTI tekniska kansli"
		Creator= SFTI/SL
		created= 2018-XX-XX
		conformsTo= UBL-Invoice-2.1.xsd and UBL-CreditNote-2.1.xsd
		description= "Stylesheet for PEPPOL BIS BILLING 3, covering Invoice and Credit Note.
		This stylesheet was drawn up to serve developers and end-users as a neutral reference tool when
		assessing transaction content. The purpose of the reference stylesheet is
		- To visualise all data structures, including all their occurrences, in transaction instances 
		  compliant to BIS BILLING 3; 
		- To show all data as is, i.e. without any editing;
		- To show relevant attributes: that is, attributes are displayed only to the extent that they have 
		  any impact on the understanding or interpretation of an element value. For example, a fix listID  
		  (like UNCL1001) would not be displayed. 

		The assumption is that is that the stylesheet is applied to messages that are formally correct, i.e. 
		messages that comply with XML schema and schematron rules. However, as this reference stylesheet is 
		likely to be used also in test environments, some basic validation features have been included, 
		and any consequential errors are displayed as needed."
		
		all terms derived from http://dublincore.org/documents/dcmi-terms/

		Derived from work by OIOUBL, Denmark. For more information, see www.sfti.se or email tekniskt.kansli@skl.se
		
******************************************************************************************************************
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fcn="urn:sfti:se:xsl:functions" xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" xmlns:n2="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" xmlns:cdl="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" exclude-result-prefixes="n1 n2 cdl cac cbc ccts sdt udt">
	<xsl:include href="CommonTemplates.xsl"/>
	<xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" indent="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:param name="stylesheet_url" select="'NONE'"/>
	<xsl:template name="doc-head">
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
		<xsl:choose>
			<xsl:when test="$stylesheet_url = 'NONE'">
				<style>* {
    box-sizing: border-box;
}

:root {
  --white: #ffffff;
  --grey: #f3f3f2;
  --Line-color: #979797;
  --font-color: #484848;
}

/* Text styles */

h1 {
  font-family: Helvetica;
  font-size: 3.3vw;
  font-weight: bold;
  font-style: normal;
  font-stretch: normal;
  line-height: 3.5vw;
  letter-spacing: normal;
  color: #484848;
}

h2 {
  font-family: Helvetica;
  font-size: 2.4vw;
  font-weight: bold;
  font-style: normal;
  font-stretch: normal;
  line-height: 2.5vw;
  letter-spacing: normal;
  color: #484848;
  margin:0px;
}

h3 {
  font-family: Helvetica;
  font-size: 1.9vw;
  font-weight: bold;
  font-style: normal;
  font-stretch: normal;
  line-height: 2vw;
  letter-spacing: normal;
  color: #484848;
  margin:0px;
}


h4 {
  font-family: Helvetica;
  font-size: 1.3vw;
  font-weight: bold;
  font-style: normal;
  font-stretch: normal;
  line-height: 1.5vw;
  letter-spacing: normal;
  color: #484848;
  margin:0px;
}

p,th,td {
  font-family: Helvetica;
  font-size: 1.2vw;
  font-weight: normal;
  font-style: normal;
  font-stretch: normal;
  line-height: 1.5vw;
  letter-spacing: normal;
  color: #484848;
  margin-top:0.5vw;
  margin-bottom:0.5vw;
}


table
{
	
	/*border: 2px solid black;*/
	width: 100%;
	
}
table, th, td
{
border-collapse: collapse;
}
tr
{
	vertical-align: top;
}
tr:nth-child(even) {
    background-color: #f3f3f2;
}

td
{
	vertical-align: top;
	border-bottom:1px solid #979797;
	/*border:2px solid black;*/
}


th
{
	border-bottom: 2px solid #979797;
	font-weight:normal;
}


td.UBLLine
{
	color:#979797;
	margin: 0em;
}

hr
{
color:var(--Line-color);

}



.col-1 {width: 8.33%;}
.col-2 {width: 16.66%;}
.col-3 {width: 25%;}
.col-4 {width: 33.33%;}
.col-5 {width: 41.66%;}
.col-6 {width: 50%;}
.col-7 {width: 58.33%;}
.col-8 {width: 66.66%;}
.col-9 {width: 75%;}
.col-10 {width: 83.33%;}
.col-11 {width: 91.66%;}
.col-12 {width: 100%;}

[class*="col-"] {
    float: left;
    padding: 1px;
	margin-top:1px;
	border: solid 0px #979797;
}

.row::after {
    content: "";
    clear: both;
    display: table;
}
#bottomrow{

border-bottom:2px solid #979797;
}
#wrapper{
padding:1vw;
border: 1px solid #979797;
}
#footer
{
border-top: 2px solid #979797;
background-color: #f3f3f2;
padding:0px;
margin-top:1vw;
}
#header
{
padding: 0.5vw;
}
#headerrow
{
padding-top:1vw;
border-bottom:1px solid #979797;
}
#tablerow
{
padding-top:1vw;
}

</style>
			</xsl:when>
			<xsl:otherwise>
				<link rel="stylesheet" href="{$stylesheet_url}"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="n1:Invoice | n2:CreditNote">
		<!-- Start HTML -->
		<html>
			<xsl:call-template name="doc-head"/>
			<head>
				<link rel="Stylesheet" type="text/css" href="PEPPOL.css"/>
				<meta name="viewport" content="width=device-width,initial-scale=1"/>
				<title>PEPPOL BIS-BILLING 3 Invoice AND CREDIT NOTE</title>
			</head>
			<body>
				<div id="wrapper">
					<!-- Start on Invoice Type row-->
					<div class="row" id="bottomrow">
						<div class="col-6">
							<!--<xsl:value-of select="fcn:LabelName('BT-3', 'true')"/>-->
							<xsl:if test="local-name(.)  = 'Invoice'">
								<h2 style="margin-bottom:0px">
									<xsl:value-of select="fcn:DocumentHeader(local-name(.))"/>
								</h2>
								<xsl:if test="cbc:InvoiceTypeCode !='380'">
									<h3 style="margin-top:0px">
										<xsl:value-of select="fcn:DocumentCode(cbc:InvoiceTypeCode)"/>
									</h3>
								</xsl:if>
							</xsl:if>
							<xsl:if test="local-name(.)  = 'CreditNote'">
								<h2 style="margin-bottom:0px">
									<xsl:value-of select="fcn:DocumentHeader(local-name(.))"/>
								</h2>
								<xsl:if test="cbc:CreditNoteTypeCode != '381'">
									<h3 style="margin-top:0px">
										<xsl:value-of select="fcn:DocumentCode(cbc:CreditNoteTypeCode)"/>
									</h3>
								</xsl:if>
							</xsl:if>
							<h1>
								<xsl:choose>
									<xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name !=''">
										<xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/>
									</xsl:otherwise>
								</xsl:choose>
							</h1>
						</div>
						<div class="col-6" id="header">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-2', 'false')"/>
									</b>
									<br/>
									<!-- Inserting Invoice Date -->
									<xsl:value-of select="cbc:IssueDate"/>
									<br/>
								</p>
								<p align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-9', 'false')"/>
									</b>
									<br/>
									<!-- Inserting Due Date:  -->
									<xsl:if test="local-name(.) = 'CreditNote'">
										<xsl:variable name="DueDates">
											<xsl:for-each select="cac:PaymentMeans">
												<xsl:if test="cbc:PaymentDueDate !=''">
													<item><xsl:value-of select="cbc:PaymentDueDate"/></item>
												</xsl:if>
											</xsl:for-each>
										</xsl:variable>
									<xsl:value-of select="$DueDates[1]"/>
									</xsl:if>
									<xsl:if test="local-name(.) = 'Invoice'">
										<xsl:value-of select="cbc:DueDate"/>
									</xsl:if>
									<br/>
								</p>
								<xsl:if test="cac:InvoicePeriod !=''">
									<xsl:if test="cac:InvoicePeriod/cbc:StartDate !=''">
										<p align="left">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-73', 'false')"/>
											</b>
											<br/>
											<xsl:apply-templates select="cac:InvoicePeriod/cbc:StartDate"/>
											<br/>
										</p>
									</xsl:if>
									<xsl:if test="cac:InvoicePeriod/cbc:EndDate !='' ">
										<p align="left">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-74', 'false')"/>
											</b>
											<br/>
											<xsl:apply-templates select="cac:InvoicePeriod/cbc:EndDate"/>
										</p>
									</xsl:if>
								</xsl:if>
							</div>
							<!--Start of invoice Header Information:-->
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-1', 'false')"/>
									</b>
									<!-- Inserting Invoice ID -->
									<br/>
									<xsl:value-of select="cbc:ID"/>
									<br/>
								</p>
								<p align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-13', 'false')"/>
									</b>
									<br/>
									<!-- Inserting Order reference number  -->
									<xsl:value-of select="cac:OrderReference/cbc:ID"/>
									<br/>
								</p>
								<p align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-10', 'false')"/>
									</b>
									<br/>
									<!-- Inserting Buyer Reference::  -->
									<xsl:value-of select="cbc:BuyerReference"/>
									<br/>
								</p>
								<xsl:choose>
									<xsl:when test="cac:LegalMonetaryTotal/cbc:PayableAmount &lt; '0'">
										<p align="left" style="color:red">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-115', 'false')"/>
											</b>
											<br/>
											<!-- Inserting Total Payable amount  -->
											
											<xsl:value-of select="fcn:Currency(cac:LegalMonetaryTotal/cbc:PayableAmount)"/>&#160;<xsl:value-of select="cbc:DocumentCurrencyCode"/>
											<br/>
										</p>
									</xsl:when>
									<xsl:otherwise>
										<p align="left">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-115', 'false')"/>
											</b>
											<br/>
											<!-- Inserting Total Payable amount  -->
											
											<xsl:value-of select="fcn:Currency(cac:LegalMonetaryTotal/cbc:PayableAmount)"/>&#160;<xsl:value-of select="cbc:DocumentCurrencyCode"/>
											<br/>
										</p>
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</div>
						<!--End of invoice Header Information-->
					</div>
					<div class="row" id="headerrow">
						<div class="col-3">
							<!-- Inserting Accounting Customer Party -->
							<p>
								<b>
									<xsl:value-of select="fcn:LabelName('BG-7', 'false')"/>
								</b>
								<br/>
								<xsl:apply-templates select="cac:AccountingCustomerParty"/>
							</p>
						</div>
						<div class="col-3">
						<p>
							<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact !='' or cbc:AccountingCost !=''">
								<!-- Inserting Contact information-->
								
									<b>
										<xsl:value-of select="fcn:LabelName('BG-9', 'false')"/>
									</b>
									<br/>
									<xsl:call-template name="BuyerContact"/>
							</xsl:if>
							<xsl:if test="cbc:AccountingCost !=''">
										<b>
										<xsl:value-of select="fcn:LabelName('BT-19', 'true')"/>
										</b>
									<xsl:value-of select="cbc:AccountingCost"/>
							</xsl:if>
							</p>
						</div>
						<div class="col-6">
						<xsl:if test="cac:ContractDocumentReference !=''">
								<p>
									<b>
										<xsl:value-of select="fcn:LabelName('BT-12', 'true')"/>
									</b>
									<xsl:apply-templates select="cac:ContractDocumentReference"/>
								</p>
							</xsl:if>
							<xsl:if test="cbc:Note[.!='']">
								<p>
									<b>
										<xsl:value-of select="fcn:LabelName('BT-22', 'false')"/>
									</b>
									<br/>
									<xsl:apply-templates select="cbc:Note"/>
								</p>
							</xsl:if>
							
						</div>
						<!--Start of Payee Row-->
					</div>
					<div class="row" id="headerrow">
						<div class="col-3">
							<xsl:apply-templates select="cac:Delivery" mode="DocumentHeader"/>
							<xsl:if test="cac:Delivery/cbc:ActualDeliveryDate !=' '">
								<xsl:if test="cac:Delivery/cbc:ActualDeliveryDate !=''">
									<p>
										<b>
											<xsl:value-of select="fcn:LabelName('BT-72', 'true')"/>
										</b>
										<xsl:apply-templates select="cac:Delivery/cbc:ActualDeliveryDate"/>
									</p>
								</xsl:if>
							</xsl:if>
						</div>
						<div class="col-3">
							<xsl:if test="cac:PayeeParty !=''">
								<!-- Inserting Payee Party -->
								<p>
									<b>
										<xsl:value-of select="fcn:LabelName('BG-10', 'false')"/>
									</b>
									<br/>
									<xsl:call-template name="PayeeParty"/>
								</p>
							</xsl:if>
						</div>
						<div class="col-6">
						<p>
							<xsl:if test="cac:AdditionalDocumentReference !=''">
								
									<b>
										<xsl:value-of select="fcn:LabelName('BG-24', 'false')"/>
									</b>
									<br/>
									<xsl:apply-templates select="cac:AdditionalDocumentReference[cbc:DocumentTypeCode != '130' and cbc:DocumentTypeCode != '50' or not(exists(cbc:DocumentTypeCode))]" mode="Supporting"/>
								
							</xsl:if>
							<xsl:if test="cac:BillingReference !=''">
								
									<xsl:for-each select="cac:BillingReference/cac:InvoiceDocumentReference">
										<br/>
										<b>
											<xsl:value-of select="fcn:LabelName('BT-25', 'true')"/>
										</b>
										<!-- Inserting Preceding invoice number  -->
										<xsl:value-of select="cbc:ID"/>
										<!-- Inserting Preceding Invoice Issue Date  -->
										<xsl:if test="cbc:IssueDate != ''">
										 ( <xsl:value-of select="cbc:IssueDate"/> )
										 </xsl:if>
									</xsl:for-each>
								
							</xsl:if>
							<xsl:if test="cac:AdditionalDocumentReference !=''">
								
									<xsl:apply-templates select="cac:AdditionalDocumentReference[cbc:DocumentTypeCode='130' or cbc:DocumentTypeCode='50']" mode="InvoicedObject"/>
								
							</xsl:if>
							<xsl:if test="cac:DespatchDocumentReference/cbc:ID">
								
									<br/>
									<b>
										<xsl:value-of select="fcn:LabelName('BT-16', 'true')"/>
									</b>
									<!-- Inserting Despatch advice reference  -->
									<xsl:value-of select="cac:DespatchDocumentReference/cbc:ID"/>
								
							</xsl:if>
							<xsl:if test="cac:ReceiptDocumentReference/cbc:ID">
								
										<br/>
										<b>
											<xsl:value-of select="fcn:LabelName('BT-15', 'true')"/>
										</b>
										<!-- Inserting Receipt advice reference  -->
										<xsl:value-of select="cac:ReceiptDocumentReference/cbc:ID"/>
								
							</xsl:if>
							<xsl:if test="cac:OriginatorDocumentReference/cbc:ID">
								
									<br/>
										<b>
											<xsl:value-of select="fcn:LabelName('BT-17', 'true')"/>
										</b>
										<!-- Inserting Originator advice reference  -->
										<xsl:value-of select="cac:OriginatorDocumentReference/cbc:ID"/>
								
							</xsl:if>
							<xsl:if test="cac:ProjectReference/cbc:ID">
									
										<br/>
										<b>
											<xsl:value-of select="fcn:LabelName('BT-11', 'true')"/>
										</b>
										<!-- Inserting Project advice reference  -->
										<xsl:value-of select="cac:ProjectReference/cbc:ID"/>
									
							</xsl:if>
							</p>
						
						</div>
					</div>
					<!--Start Invoiceline-->
					<div class="row" id="tablerow">
						<div class="col-12">
							<table>
								<tr class="UBLInvoiceLineHeader">
									<th align="left" valign="top" width="5%">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-126', 'false')"/>
										</b>
									</th>
									<th align="left" valign="top" width="10%">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-155', 'false')"/>
										</b>
									</th>
									<th align="left" valign="top" width="35%">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-153', 'false')"/>
										</b>
									</th>
									<th valign="top" align="left" width="10%">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-129', 'false')"/>
										</b>
									</th>
									<th align="left" valign="top" width="10%">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-146', 'false')"/>
										</b>
									</th>
									<th align="left" valign="top" width="10%">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-151', 'false')"/>
										</b>
									</th>
									<th align="left" valign="top" width="10%">
										<b>
											<xsl:value-of select="fcn:LabelName('BG-28', 'false')"/><br/><xsl:value-of select="fcn:LabelName('BG-27', 'false')"/>
										</b>
									</th>
									<th align="right" valign="top" width="10%">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-131', 'false')"/>
										</b>
									</th>
								</tr>
								<xsl:if test="cac:InvoiceLine != ''">
									<xsl:apply-templates select="cac:InvoiceLine"/>
								</xsl:if>
								<xsl:if test="cac:CreditNoteLine != ''">
									<xsl:apply-templates select="cac:CreditNoteLine"/>
								</xsl:if>
							</table>
						</div>
					</div>
					<!--End Invoiceline-->
					<!-- Start sum of invoice line net amount: -->
					<div class="row" id="sum">
						<div class="col-6">
							<p align="left">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-106', 'true')"/>
								</b>
							</p>
						</div>
						<div class="col-6">
							<p align="right">
								<b>
									<xsl:apply-templates select="fcn:Currency(cac:LegalMonetaryTotal/cbc:LineExtensionAmount)"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID"/>
								</b>
							</p>
						</div>
					</div>
					<!-- End Sum of invoice line net amount -->
					<!-- Start Allowances and charges on document level: -->
					<!--Start Document allowances-->
					<xsl:if test="cac:AllowanceCharge[cbc:ChargeIndicator ='false']">
						<div class="row" id="tablerow">
							<div class="col-12">
								<h3>
									<xsl:value-of select="fcn:LabelName('BG-20', 'false')"/>
								</h3>
								<table>
									<tr>
										<th align="left" valign="top" colspan="2" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-105', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" colspan="2" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-104', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-102', 'false')"/>
											</b>
										</th>
										<th align="right" valign="top" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-93', 'false')"/>
											</b>
										</th>
										<th valign="top" align="right" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-99', 'false')"/>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:AllowanceCharge">
										<xsl:if test="cbc:ChargeIndicator ='false'">
											<xsl:call-template name="Allowance"/>
										</xsl:if>
									</xsl:for-each>
								</table>
							</div>
						</div>
					</xsl:if>
					<!--End Document allowances-->
					<!-- Start AllowanceTotal Amount: -->
					<xsl:if test="cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount !='' ">
						<div class="row" id="sum">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-107', 'true')"/>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
									<b>
										<xsl:apply-templates select="fcn:Currency(cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount)"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID"/>
									</b>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- End AllowanceTotal Amount -->
					<!--Start Document Charges-->
					<xsl:if test="cac:AllowanceCharge[cbc:ChargeIndicator ='true']">
						<div class="row" id="tablerow">
							<div class="col-12">
								<h3>
									<xsl:value-of select="fcn:LabelName('BG-21', 'false')"/>
								</h3>
								<table>
									<tr>
										<th align="left" valign="top" colspan="2" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-98', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" colspan="2" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-97', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-95', 'false')"/>
											</b>
										</th>
										<th align="right" valign="top" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-100', 'false')"/>
											</b>
										</th>
										<th valign="top" align="right" width="20%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-92', 'false')"/>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:AllowanceCharge">
										<xsl:if test="cbc:ChargeIndicator ='true'">
											<xsl:call-template name="Charge"/>
										</xsl:if>
									</xsl:for-each>
								</table>
							</div>
						</div>
					</xsl:if>
					<!--End Document Charges-->
					<!-- Start ChargeTotal Amount: -->
					<xsl:if test="cac:LegalMonetaryTotal/cbc:ChargeTotalAmount !='' ">
						<div class="row" id="sum">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-108', 'true')"/>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
									<b>
										<xsl:apply-templates select="fcn:Currency(cac:LegalMonetaryTotal/cbc:ChargeTotalAmount)"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:ChargeTotalAmount/@currencyID"/>
									</b>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- End ChargeTotal Amount -->
					<!-- Start VAT Breakdown: -->
					<div class="row" id="tablerow">
						<div class="col-12">
							<h3>
								<xsl:value-of select="fcn:LabelName('BG-23', 'false')"/>
							</h3>
							<p>
								<xsl:if test="cbc:TaxPointDate !=''">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-7', 'true')"/>
									</b>
									<xsl:value-of select="cbc:TaxPointDate"/>
								</xsl:if>
								<xsl:if test="cac:InvoicePeriod/cbc:DescriptionCode != ''">
										<br/>
										<b>
											<xsl:value-of select="fcn:LabelName('BT-8', 'true')"/>
										</b>
										<xsl:value-of select="fcn:UBLDescriptionCode(cac:InvoicePeriod/cbc:DescriptionCode)"/> [<xsl:value-of select="cac:InvoicePeriod/cbc:DescriptionCode"/>]
<br/>
								</xsl:if>
									
								
							</p>
						</div>
					</div>
					<div class="row" id="tablerow">
						<div class="col-12">
							<table>
								<xsl:if test="cac:TaxTotal">
									<tr class="TAXInformationHeader">
										<th align="left" valign="top" colspan="2" width="25%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-118', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" colspan="2" width="25%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-120', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" colspan="2" width="25%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-116', 'false')"/>
											</b>
										</th>
										<!--th valign="top" align="right">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-111', 'true')"/>
										</b>
									</th-->
										<th valign="top" align="right" width="25%">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-117', 'false')"/>
											</b>
										</th>
									</tr>
									<xsl:apply-templates select="cac:TaxTotal/cac:TaxSubtotal"/>
								</xsl:if>
							</table>
						</div>
					</div>
					<!--End VAT Breakdown -->
					<!-- Start Tax Amount: -->
					<xsl:if test="cbc:TaxCurrencyCode !=''">
						<div class="row">
							<div class="col-12">
								<p>
									<b>
										<xsl:value-of select="fcn:LabelName('BT-6', 'true')"/>
									</b>
									<xsl:value-of select="cbc:TaxCurrencyCode"/>
								</p>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="cac:TaxTotal/cbc:TaxAmount">
						<xsl:if test="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]">
							<div class="row" id="headerrow">
								<div class="col-6">
									<p>
										<b>
											<xsl:value-of select="fcn:LabelName('BT-110', 'true')"/>
										</b>
									</p>
								</div>
								<div class="col-3">
									<p align="right">
										<xsl:apply-templates select="fcn:Currency(cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:TaxCurrencyCode])"/>&#160;<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:TaxCurrencyCode]/@currencyID"/>
									</p>
								</div>
								<div class="col-3">
									<p align="right">
										<b>
											<xsl:apply-templates select="fcn:Currency(cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode])"/>&#160;<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]/@currencyID"/>
										</b>
									</p>
								</div>
							</div>
						</xsl:if>
					</xsl:if>
					<!-- End Tax Amount -->
					<!-- Start TaxExclusive Amount: -->
					<div class="row" id="headerrow">
						<div class="col-6">
							<p align="left">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-109', 'true')"/>
								</b>
							</p>
						</div>
						<div class="col-6">
							<p align="right">
								<xsl:apply-templates select="fcn:Currency(cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount)"/>
							</p>
						</div>
					</div>
					<!-- End TaxExclusive Amount -->
					<!-- Start TaxInclusive Amount: -->
					<div class="row" id="headerrow">
						<div class="col-6">
							<p align="left">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-112', 'true')"/>
								</b>
							</p>
						</div>
						<div class="col-6">
							<p align="right">
								<b>
									<xsl:apply-templates select="fcn:Currency(cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount)"/>
								</b>
							</p>
						</div>
					</div>
					<!-- End TaxInclusive Amount -->
					<!-- Start Prepaid Amount: -->
					<xsl:if test="cac:LegalMonetaryTotal/cbc:PrepaidAmount !='' ">
						<div class="row" id="headerrow">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-113', 'true')"/>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
									<xsl:apply-templates select="fcn:Currency(cac:LegalMonetaryTotal/cbc:PrepaidAmount)"/>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- End Prepaid Amount -->
					<!-- Start Rounding Amount: -->
					<xsl:if test="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount !='' ">
						<div class="row" id="headerrow">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-114', 'true')"/>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
									<xsl:apply-templates select="fcn:Currency(cac:LegalMonetaryTotal/cbc:PayableRoundingAmount)"/>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- End Rounding Amount -->
					<!-- Start Payable Amount: -->
					<div class="row" id="headerrow">
						<xsl:choose>
							<xsl:when test="cac:LegalMonetaryTotal/cbc:PayableAmount &lt; '0'">
								<div class="col-6">
									<h2 align="left" style="color:red">
										<xsl:value-of select="fcn:LabelName('BT-115', 'true')"/>
									</h2>
								</div>
								<div class="col-6">
									<h2 align="right" style="color:red">
										<xsl:apply-templates select="fcn:Currency(cac:LegalMonetaryTotal/cbc:PayableAmount)"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/>
									</h2>
								</div>
							</xsl:when>
							<xsl:otherwise>
								<div class="col-6">
									<h2 align="left">
										<xsl:value-of select="fcn:LabelName('BT-115', 'true')"/>
									</h2>
								</div>
								<div class="col-6">
									<h2 align="right">
										<xsl:apply-templates select="fcn:Currency(cac:LegalMonetaryTotal/cbc:PayableAmount)"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/>
									</h2>
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</div>
					<!-- End Payable Amount -->
					<!-- Start document totals: -->
					<!-- Start on PAYMENT TERMS information -->
					<xsl:if test="cac:PaymentTerms !=''">
						<div class="row" id="tablerow">
							<div class="col-12">
								<h3>
									<xsl:value-of select="fcn:LabelName('BT-20', 'true')"/>
								</h3>
								<p>
									<xsl:apply-templates select="cac:PaymentTerms"/>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- Start on PAYMENT MEANS information -->
					<div class="row" id="tablerow">
						<div class="col-12">
							<h3>
								<xsl:value-of select="fcn:LabelName('BG-16', 'false')"/>
							</h3>
							<xsl:if test="cac:PaymentMeans/cac:PayeeFinancialAccount !=''">
								<table>
									<tr>
										<th align="left" valign="top">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-81', 'false')"/>
											</b>&#160;&#160;
								</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-86', 'false')"/>
											</b>
										</th>
									
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-84', 'false')"/>
											</b>
										</th>
											
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-85', 'false')"/>
											</b>
										</th>
										<th align="right" valign="top">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-83', 'false')"/>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:PaymentMeans">
										<xsl:if test="cac:PayeeFinancialAccount !=''">
											<xsl:call-template name="cac:PaymentMeans"/>
										</xsl:if>
									</xsl:for-each>
										<xsl:for-each select="cac:PaymentMeans">
										<xsl:if test="not(cac:PaymentMandate) and not(cac:CardAccount) and not(cac:PayeeFinancialAccount)">
											<xsl:call-template name="cac:PaymentMeans"/>
										</xsl:if>
									</xsl:for-each>
								</table>
							</xsl:if>
							<xsl:if test="cac:PaymentMeans/cac:CardAccount !=''">
								<table>
									<tr>
										<th align="left" valign="top">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-81', 'false')"/>
											</b>&#160;&#160;
								</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-86-1', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-87', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-88', 'false')"/>
											</b>
										</th>
										<th align="right" valign="top">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-83', 'false')"/>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:PaymentMeans">
										<xsl:if test="cac:CardAccount !=''">
											<xsl:call-template name="cac:PaymentMeans"/>
										</xsl:if>
									</xsl:for-each>
								</table>
							</xsl:if>
							<xsl:if test="cac:PaymentMeans/cac:PaymentMandate !=''">
								<table>
									<tr>
										<th align="left" valign="top">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-81', 'false')"/>
											</b>&#160;&#160;
								</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-91', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-89', 'false')"/>
											</b>
										</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-90', 'false')"/>
											</b>
										</th>
										<th align="right" valign="top">
											<b>
												<xsl:value-of select="fcn:LabelName('BT-83', 'false')"/>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:PaymentMeans">
										<xsl:if test="cac:PaymentMandate !=''">
											<xsl:call-template name="cac:PaymentMeans"/>
										</xsl:if>
									</xsl:for-each>
								
								</table>
							</xsl:if>
						</div>
					</div>
					<!-- End of PAYMENT MEANS information -->
					<!-- Seller Row starts here-->
					<div class="row" id="footer">
						<div class="col-4">
							<!-- Inserting Accounting Supplier Party-->
							<p>
								<b>
									<xsl:value-of select="fcn:LabelName('BG-4', 'false')"/>
								</b>
								<br/>
								<xsl:apply-templates select="cac:AccountingSupplierParty"/>
							</p>
						</div>
						<div class="col-4">
							<!-- Inserting contact information -->
							<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact !=''">
								<p>
									<b>
										<xsl:value-of select="fcn:LabelName('BG-6', 'false')"/>
									</b>
									<xsl:call-template name="SellerContact"/>
								</p>
							</xsl:if>
							<xsl:if test="cac:OrderReference/cbc:SalesOrderID">
								<p align="left">
									<xsl:value-of select="fcn:LabelName('BT-14', 'true')"/>
									<!-- Inserting Sales order reference number  -->
									<xsl:value-of select="cac:OrderReference/cbc:SalesOrderID"/>
									<br/>
								</p>
							</xsl:if>
							
						</div>
						<div class="col-4">
							<xsl:if test="cac:TaxRepresentativeParty !=''">
								<p>
									<b>
										<xsl:value-of select="fcn:LabelName('BG-11', 'false')"/>
									</b>
									<br/>
									<xsl:apply-templates select="cac:TaxRepresentativeParty"/>
								</p>
							</xsl:if>
						</div>
					</div>
					<!-- End of Invoice Note information -->
					<!-- Start on technical stylesheet footer - for all transactions -->
					<div class="row" id="tablerow">
						<div class="col-12">
							<p>
							<small>
								<xsl:value-of select="cbc:UBLVersionID"/>
								<br/>
								<xsl:value-of select="fcn:LabelName('BT-23', 'true')"/>
								<xsl:value-of select="cbc:ProfileID"/>
								<br/>
								<xsl:value-of select="fcn:LabelName('BT-24', 'true')"/>
								<xsl:value-of select="cbc:CustomizationID"/>
								<xsl:if test="cbc:UUID !=''">
									<xsl:value-of select="cbc:UUID"/>
									<br/>
								</xsl:if>
								<xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID">
									<br/>
								
										<xsl:value-of select="fcn:LabelName('BT-34', 'true')"/>
										<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID"/>
										<xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID !='' ">
											[<xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID"/>]
										</xsl:if>
								
								</xsl:if>
								<xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID">
									<br/>
								
										<xsl:value-of select="fcn:LabelName('BT-49', 'true')"/>
										<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID"/>
										<xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID !='' ">
										[<xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID"/>]
										</xsl:if>
										</xsl:if>
					<br/>This invoice visualization is generated from SFTI BIS Billing 3 XSL Stylesheet Version 1.0.2<br/>
					This stylesheet uses business terms defined the CEN/EN16931-1 and is reproduced with permission from CEN. CEN bears no liability from the use of the content and implementation of this stylesheet and gives no warranties expressed or implied for any purpose.<br/>
					This visualization was generated: <xsl:value-of  select="current-dateTime()"/>
					
					
								
								</small>
							</p>
						</div>
					</div>
					<!-- End of technical stylesheet footer-->
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
