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
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fcn="urn:sfti:se:xsl:functions" xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" xmlns:n2="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" exclude-result-prefixes="n1 n2 cac cbc ccts sdt udt">
	<xsl:include href="CommonTemplates.xsl"/>
	<xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" indent="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="n1:Invoice">
		<!-- Start HTML -->
		<html>
			<head>
				<link rel="Stylesheet" type="text/css" href="PEPPOL.css"/>
				<meta name="viewport" content="width=device-width,initial-scale=1"/>
				<title>PEPPOL BIS-BILLING 3 Invoice AND CREDIT NOTE</title>
			</head>
			<body>
				<!-- Start on Invoice Type row-->
				<div class="row">
					<div class="col-6">
						<h2>
							<xsl:value-of select="fcn:LabelName('BT-3', 'true')"/>
							<xsl:if test="cbc:InvoiceTypeCode !=''">
								<xsl:value-of select="fcn:DocumentCode(cbc:InvoiceTypeCode)"/>
							</xsl:if>
						</h2>
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
							<p align="right">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-9', 'true')"/>
								</b>
								<br/>
								<!-- Inserting Due Date:  -->
								<xsl:value-of select="cbc:DueDate"/>
								<br/>
								<br/>
								<b>
									<xsl:value-of select="fcn:LabelName('BT-2', 'true')"/>
								</b>
								<br/>
								<!-- Inserting Invoice Date -->
								<xsl:value-of select="cbc:IssueDate"/>
								<br/>
								<br/>
								<xsl:if test="cac:InvoicePeriod !=''">
									<xsl:if test="cac:InvoicePeriod/cbc:StartDate !=''">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-73', 'true')"/>
										</b>
										<br/>
										<xsl:apply-templates select="cac:InvoicePeriod/cbc:StartDate"/>
										<br/>
									</xsl:if>
									<xsl:if test="cac:InvoicePeriod/cbc:EndDate !='' ">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-74', 'true')"/>
										</b>
										<br/>
										<xsl:apply-templates select="cac:InvoicePeriod/cbc:EndDate"/>
									</xsl:if>
								</xsl:if>
								
							</p>
						</div>
						<!--Start of invoice Header Information:-->
						<div class="col-6">
							<p align="right">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-1', 'true')"/>
								</b>
								<!-- Inserting Invoice ID -->
								<br/>
								<xsl:value-of select="cbc:ID"/>
								<br/>
								<b>
									<xsl:value-of select="fcn:LabelName('BT-13', 'true')"/>
								</b>
								<br/>
								<!-- Inserting Order reference number  -->
								<xsl:value-of select="cac:OrderReference/cbc:ID"/>
								<br/>
								<b>
									<xsl:value-of select="fcn:LabelName('BT-10', 'true')"/>
								</b>
								<br/>
								<!-- Inserting Buyer Reference::  -->
								<xsl:value-of select="cbc:BuyerReference"/>
							
								
								<br/>
								<b>
									<xsl:value-of select="fcn:LabelName('BT-115', 'true')"/>
								</b>
								<br/>
								<!-- Inserting Total Payable amount  -->
								<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableAmount"/>&#160;<xsl:value-of select="cbc:DocumentCurrencyCode"/>
								<br/>
							</p>
						</div>
					</div>
					<!--End of invoice Header Information-->
				</div>
				<div class="row" id="tablerow">
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
						<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact !=''">
							<!-- Inserting Contact information-->
							<p>
								<b>
									<xsl:value-of select="fcn:LabelName('BG-9', 'false')"/>
								</b>
								<br/>
								<xsl:call-template name="BuyerContact"/>
							</p>
						</xsl:if>
					</div>
					<!--Start of Payee Row-->
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
					<div class="col-3">
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
				<div class="row" id="tablerow">
					<div class="col-3">
						
							<xsl:apply-templates select="cac:Delivery" mode="DocumentHeader"/>
							<xsl:if test="cac:Delivery/cbc:ActualDeliveryDate !=' '">
								<xsl:if test="cac:Delivery/cbc:ActualDeliveryDate !=''">
<p>
									<b><xsl:value-of select="fcn:LabelName('BT-72', 'true')"/></b>
									<xsl:apply-templates select="cac:Delivery/cbc:ActualDeliveryDate"/>
									</p>
								</xsl:if>
							</xsl:if>
						
					</div>
					<div class="col-3">
						<xsl:if test="cac:PayeeParty !=''">
							<xsl:if test="cbc:Note[.!='']">
								<p>
									<b>
										<xsl:value-of select="fcn:LabelName('BT-22', 'false')"/>
									</b>
									<br/>
									<xsl:apply-templates select="cbc:Note"/>
								</p>
							</xsl:if>
						</xsl:if>
						<xsl:if test="cac:ContractDocumentReference !=''">
							<p>
								<b>
									<xsl:value-of select="fcn:LabelName('BT-12', 'true')"/>
								</b>
								<xsl:apply-templates select="cac:ContractDocumentReference"/>
							</p>
						</xsl:if>
					</div>
					<div class="col-6">
						<xsl:if test="cac:AdditionalDocumentReference !=''">
							<p>
								<b>
									<xsl:value-of select="fcn:LabelName('BG-24', 'false')"/>
								</b>
								<xsl:apply-templates select="cac:AdditionalDocumentReference"/>
							</p>
						</xsl:if>
					</div>
				</div>
				<!--Start Invoiceline-->
				<div class="row" id="tablerow">
					<div class="col-12">
						<table>
							<tr class="UBLInvoiceLineHeader">
								<th align="left" valign="top">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-126', 'false')"/>
									</b>
								</th>
								<th align="left" valign="top">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-155', 'false')"/>
									</b>
								</th>
								<th align="left" valign="top">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-153', 'false')"/>
									</b>
								</th>
								<th valign="top" align="left">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-129', 'false')"/>
									</b>
								</th>
								<th align="left" valign="top">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-146', 'false')"/>
									</b>
								</th>
								<th align="left" valign="top">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-151', 'false')"/>
									</b>
								</th>
								<th align="left" valign="top">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-136', 'false')"/>
									</b>
								</th>
								<th align="right" valign="top">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-131', 'false')"/>
									</b>
								</th>
							</tr>
							<xsl:apply-templates select="cac:InvoiceLine"/>
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
							<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:LineExtensionAmount"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID"/></b>
						</p>
					</div>
				</div>
				<!-- End Sum of invoice line net amount -->
				<!-- Start Allowances and charges on document level: -->
				<!--Start Document allowances-->
				<xsl:if test="cac:AllowanceCharge[cbc:ChargeIndicator ='false']">
					<div class="row" id="tablerow">
						<div class="col-12">
							<p>
								<b>
									<xsl:value-of select="fcn:LabelName('BG-20', 'false')"/>
								</b>
							</p>
							<table>
								<tr>
									<th align="left" valign="top" colspan="2">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-105', 'false')"/>
										</b>
									</th>
									<th align="left" valign="top" colspan="2">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-104', 'false')"/>
										</b>
									</th>
									<th align="left" valign="top">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-102', 'false')"/>
										</b>
									</th>
									<th valign="top" align="right">
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
								<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID"/></b>
							</p>
						</div>
					</div>
				</xsl:if>
				<!-- End AllowanceTotal Amount -->
				<!--Start Document Charges-->
				<xsl:if test="cac:AllowanceCharge[cbc:ChargeIndicator ='true']">
					<div class="row" id="tablerow">
						<div class="col-12">
							<p>
								<b>
									<xsl:value-of select="fcn:LabelName('BG-21', 'false')"/>
								</b>
							</p>
							<table>
								<tr>
									<th align="left" valign="top" colspan="2">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-98', 'false')"/>
										</b>
									</th>
									<th align="left" valign="top" colspan="2">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-97', 'false')"/>
										</b>
									</th>
									<th align="left" valign="top">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-95', 'false')"/>
										</b>
									</th>
									<th valign="top" align="right">
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
								<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:ChargeTotalAmount"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:ChargeTotalAmount/@currencyID"/></b>
							</p>
						</div>
					</div>
				</xsl:if>
				<!-- End ChargeTotal Amount -->
				<!-- Start VAT Breakdown: -->
				<div class="row" id="tablerow">
					<div class="col-12">
						<p>
							<b>
								<xsl:value-of select="fcn:LabelName('BG-23', 'false')"/>
							</b>
							<br/>
							<xsl:if test="cbc:TaxPointDate !=''">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-7', 'true')"/>
								</b>
								<xsl:value-of select="cbc:TaxPointDate"/>
								<br/>
							</xsl:if>
							<xsl:if test="cbc:TaxCurrencyCode !=''">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-6', 'true')"/>
								</b>
								<xsl:value-of select="cbc:TaxCurrencyCode"/>
							</xsl:if>
						</p>
					</div>
				</div>
				<div class="row" id="tablerow">
					<div class="col-12">
						<table>
							<xsl:if test="cac:TaxTotal">
								<tr class="TAXInformationHeader">
									<th align="left" valign="top" colspan="2">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-118', 'true')"/>
										</b>
									</th>
									<th align="left" valign="top" colspan="2">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-120', 'true')"/>
										</b>
									</th>
									<th align="left" valign="top" colspan="2">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-116', 'true')"/>
										</b>
									</th>
									<!--th valign="top" align="right">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-111', 'true')"/>
										</b>
									</th-->
									<th valign="top" align="right">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-117', 'true')"/>
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
				<xsl:if test="cac:TaxTotal/cbc:TaxAmount">
					<xsl:if test="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]">
						<div class="row" id="sum">
							<div class="col-6">
								<p>
									<b>
										<xsl:value-of select="fcn:LabelName('BT-110', 'true')"/>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
								<b>
									<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]"/>&#160;<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]/@currencyID"/></b>
								
								</p>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:TaxCurrencyCode]">
						<div class="row" id="sum">
							<div class="col-6">
								<p>
									<b>
										<xsl:value-of select="fcn:LabelName('BT-111', 'true')"/>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
									<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:TaxCurrencyCode]"/>&#160;<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:TaxCurrencyCode]/@currencyID"/>
									
								</p>
							</div>
						</div>
					</xsl:if>
				</xsl:if>
				<!-- End Tax Amount -->
				<!-- Start TaxExclusive Amount: -->
				<div class="row" id="sum">
					<div class="col-6">
						<p align="left">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-109', 'true')"/>
							</b>
						</p>
					</div>
					<div class="col-6">
						<p align="right">
							<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount/@currencyID"/>
						</p>
					</div>
				</div>
				<!-- End TaxExclusive Amount -->
				<!-- Start TaxInclusive Amount: -->
				<div class="row" id="sum">
					<div class="col-6">
						<p align="left">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-112', 'true')"/>
							</b>
						</p>
					</div>
					<div class="col-6">
						<p align="right">
							<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID"/>
						</p>
					</div>
				</div>
				<!-- End TaxInclusive Amount -->
				<!-- Start Prepaid Amount: -->
				<xsl:if test="cac:LegalMonetaryTotal/cbc:PrepaidAmount !='' ">
					<div class="row" id="sum">
						<div class="col-6">
							<p align="left">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-113', 'true')"/>
								</b>
							</p>
						</div>
						<div class="col-6">
							<p align="right">
								<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PrepaidAmount"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PrepaidAmount/@currencyID"/>
							</p>
						</div>
					</div>
				</xsl:if>
				<!-- End Prepaid Amount -->
				<!-- Start Rounding Amount: -->
				<xsl:if test="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount !='' ">
					<div class="row" id="sum">
						<div class="col-6">
							<p align="left">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-114', 'true')"/>
								</b>
							</p>
						</div>
						<div class="col-6">
							<p align="right">
								<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount/@currencyID"/>
							</p>
						</div>
					</div>
				</xsl:if>
				<!-- End Rounding Amount -->
				<!-- Start Payable Amount: -->
				<div class="row" id="sum">
					<div class="col-6">
						<p align="left">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-115', 'true')"/>
							</b>
						</p>
					</div>
					<div class="col-6">
						<p align="right">
						<b>
							<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableAmount"/>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/>
							</b>
						</p>
					</div>
				</div>
				<!-- End Payable Amount -->
				<!-- Start document totals: -->
				<!-- Start on PAYMENT TERMS information -->
				<xsl:if test="cac:PaymentTerms !=''">
					<div class="row" id="tablerow">
						<div class="col-12">
							<p>
								<b>
									<xsl:value-of select="fcn:LabelName('BT-20', 'true')"/>
								</b>
								<xsl:apply-templates select="cac:PaymentTerms"/>
							</p>
						</div>
					</div>
				</xsl:if>
				<!-- Start on PAYMENT MEANS information -->
				<div class="row" id="tablerow">
					<div class="col-12">
						<p>
							<b>
								<xsl:value-of select="fcn:LabelName('BG-16', 'false')"/>
							</b>
						</p>
						<table>
							<tr>
								<th align="left" valign="top">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-81', 'false')"/>
									</b>&#160;&#160;
								</th>
								<th align="left" valign="top">
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
										<xsl:value-of select="fcn:LabelName('BT-86', 'false')"/>
									</b>
								</th>
								<th align="right" valign="top">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-83', 'false')"/>
									</b>
								</th>
								<!--th valign="top" align="right">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-9', 'false')"/>
									</b>
								</th-->
							</tr>
							<xsl:apply-templates select="cac:PaymentMeans"/>
						</table>
					</div>
				</div>
				<!-- End of PAYMENT MEANS information -->
				<!-- Seller Row starts here-->
				<div class="row" id="footer">
					<div class="col-6">
						<!-- Inserting Accounting Supplier Party-->
						<p>
							<b>
								<xsl:value-of select="fcn:LabelName('BG-4', 'false')"/>
							</b>
							<br/>
							<xsl:apply-templates select="cac:AccountingSupplierParty"/>
						</p>
					</div>
					<div class="col-6">
						<!-- Inserting contact information -->
						<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact !=''">
							<p>
								<b>
									<xsl:value-of select="fcn:LabelName('BG-6', 'false')"/>
								</b>
								<xsl:call-template name="SellerContact"/>
							</p>
						</xsl:if>
					</div>
				</div>
				<!-- End of Invoice Note information -->
				<!-- Start on technical stylesheet footer - for all transactions -->
				<div class="row" id="tablerow">
					<div class="col-12">
						<p>
							<xsl:value-of select="cbc:UBLVersionID"/>
							<br/>
							<xsl:value-of select="fcn:LabelName('BT-23', 'true')"/>
										&#160;<xsl:value-of select="cbc:ProfileID"/>
							<b>
								<br/>
								<xsl:value-of select="fcn:LabelName('BT-24', 'true')"/>
							</b>&#160;<xsl:value-of select="cbc:CustomizationID"/>
							<xsl:if test="cbc:UUID !=''">
								<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='UUID']"/-->
								<xsl:value-of select="cbc:UUID"/>
								<br/>
							</xsl:if>
							<xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID">
								<br/>
								<small>
									<xsl:value-of select="fcn:LabelName('BT-34', 'true')"/>
									<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID"/>
									<xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID !='' ">

						&#160;[<xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID"/>]

					</xsl:if>
								</small>
							</xsl:if>
							<xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID">
								<br/>
								<small>
									<xsl:value-of select="fcn:LabelName('BT-49', 'true')"/>
									<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID"/>
									<xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID !='' ">

						&#160;[<xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID"/>]

					</xsl:if>
								</small>
							</xsl:if>
							<b>
								<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TechFooter1']"/-->
							</b>
							<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TechFooter2']"/-->
 									&#160;<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PEPPOLInvoice']"/-->
									&#160;<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TechFooter3']"/-->
							<b>
								<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TechFooter4']"/-->
								<br/>
								<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='VersionID']"/-->
							</b>&#160;
										<br/>
							<!-- Verify profile and transaction combinations: -->
							<b>
								<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ProfileName']"/-->
							</b>&#160;
				 				<xsl:choose>
								<xsl:when test="cbc:ProfileID ='urn:www.cenbii.eu:profile:bii04:ver2.0' ">
									<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ProfileBIS4a']"/-->
									<xsl:if test="cbc:CustomizationID !='urn:www.cenbii.eu:transaction:biitrns010:ver2.0:extended:urn:www.peppol.eu:bis:peppol4a:ver2.0' ">
											&#160;<em>
											<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='Profile-TransUnknown']"/-->
										</em>
									</xsl:if>
								</xsl:when>
								<xsl:when test="cbc:ProfileID ='urn:www.cenbii.eu:profile:bii05:ver2.0' ">
									<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ProfileBIS5a']"/-->
									<xsl:if test="cbc:CustomizationID !='urn:www.cenbii.eu:transaction:biitrns010:ver2.0:extended:urn:www.peppol.eu:bis:peppol5a:ver2.0' and 

											      cbc:CustomizationID !='urn:www.cenbii.eu:transaction:biitrns014:ver2.0:extended:urn:www.peppol.eu:bis:peppol5a:ver2.0'">
											&#160;<em>
											<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='Profile-TransUnknown']"/-->
										</em>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<em>
										<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ProfileUnknown']"/-->
									</em>
								</xsl:otherwise>
							</xsl:choose>
							<br/>
						</p>
					</div>
				</div>
				<!-- End of technical stylesheet footer-->
			</body>
		</html>
	</xsl:template>
	<xsl:template match="n2:CreditNote">
		<!-- Start HTML -->
		<html>
			<head>
				<link rel="Stylesheet" type="text/css" href="PEPPOL.css"/>
				<title>PEPPOL BIS 4a Invoice only AND BIS 5a Billing</title>
			</head>
			<body>
				<!-- Start on header-->
				<table border="0" width="100%" cellspacing="0" cellpadding="2">
					<tr>
						<td colspan="4" valign="top">
							<!-- Inserting Header -->
							<h3>
								<xsl:value-of select="fcn:LabelName('BT-3', 'true')"/>
								<br/>
								<xsl:if test="cbc:InvoiceTypeCode !=''">
									<xsl:value-of select="cbc:InvoiceTypeCode"/>&#160;

									
								</xsl:if>
							</h3>
						</td>
						<td colspan="2">
							<h3>
								<b>
									<xsl:value-of select="fcn:LabelName('BT-2', 'true')"/>
									&#160;</b>
								<!-- Inserting Invoice Date -->
								<br/>
								<xsl:value-of select="cbc:IssueDate"/>
							</h3>
						</td>
						<td colspan="2">
							<h3>
								<b>
									<xsl:value-of select="fcn:LabelName('BT-1', 'true')"/>
									&#160;</b>
								<!-- Inserting Invoice ID -->
								<br/>
								<xsl:value-of select="cbc:ID"/>
							</h3>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="2">
							<xsl:if test="cbc:DocumentCurrencyCode !=''">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-5', 'true')"/>
								</b>&#160;<br/>
								<xsl:value-of select="cbc:DocumentCurrencyCode"/>
							</xsl:if>
						</td>
						<td valign="top" colspan="2">
							<xsl:if test="cbc:AccountingCost !=''">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-19', 'true')"/>
									&#160;
								</b>
								<br/>
								<xsl:value-of select="cbc:AccountingCost"/>
							</xsl:if>
						</td>
						<td valign="top" colspan="2">
							<xsl:if test="cac:InvoicePeriod !=''">
								<b>
									<xsl:value-of select="fcn:LabelName('BG-14', 'true')"/>
								</b>
								<br/>
								<xsl:if test="cac:InvoicePeriod/cbc:StartDate !=''">
									<xsl:value-of select="fcn:LabelName('BT-73', 'true')"/>
									&#160;
									<xsl:apply-templates select="cac:InvoicePeriod/cbc:StartDate"/>&#160;
								</xsl:if>
								<xsl:if test="cac:InvoicePeriod/cbc:EndDate !='' ">
									<xsl:value-of select="fcn:LabelName('BT-74', 'true')"/>
									
									&#160;<xsl:apply-templates select="cac:InvoicePeriod/cbc:EndDate"/>&#160;
								</xsl:if>
							</xsl:if>
						</td>
						<td valign="top" colspan="2">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-13', 'true')"/>
								&#160;
							</b>
							<br/>
							<!-- Inserting Order reference number  -->
							<xsl:value-of select="cac:OrderReference/cbc:ID"/>
						</td>
					</tr>
					<tr>
						<td colspan="8">
							<hr size="2"/>
						</td>
					</tr>
					<!-- Start of Parties (in header) -->
					<tr>
						<td valign="top" colspan="2">
							<!-- Inserting Accounting Supplier Party-->
							<b>
								<xsl:value-of select="fcn:LabelName('BG-4', 'true')"/>
							</b>
							<br/>
							<xsl:apply-templates select="cac:AccountingSupplierParty"/>
						</td>
						<td valign="top" colspan="2">
							<!-- Inserting contact information -->
							<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact !=''">
								<b>
									<xsl:value-of select="fcn:LabelName('BG-6', 'true')"/>
								</b>
								<br/>
								<xsl:call-template name="SellerContact"/>
							</xsl:if>
						</td>
						<td valign="top" colspan="2">
							<!-- Inserting Accounting Customer Party -->
							<b>
								<xsl:value-of select="fcn:LabelName('BG-7', 'true')"/>
								hej
							</b>
							<br/>
							<xsl:apply-templates select="cac:AccountingCustomerParty"/>
						</td>
						<td valign="top" colspan="2">
							<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact !=''">
								<!-- Inserting Contact information-->
								<b>
									<xsl:value-of select="fcn:LabelName('BG-9', 'true')"/>
								</b>
								<br/>
								<xsl:call-template name="BuyerContact"/>
							</xsl:if>
						</td>
					</tr>
					<xsl:if test="cac:PayeeParty !='' or cac:TaxRepresentativeParty !='' or cac:Delivery !='' ">
						<tr>
							<td colspan="8">
								<hr size="2"/>
							</td>
						</tr>
						<tr>
							<td valign="top" colspan="2">
								<xsl:if test="cac:PayeeParty !=''">
									<!-- Inserting Payee Party -->
									<b>
										<xsl:value-of select="fcn:LabelName('BG-10', 'true')"/>
									</b>
									<br/>
									<xsl:call-template name="PayeeParty"/>
								</xsl:if>
							</td>
							<td valign="top" colspan="2">
								<xsl:if test="cac:TaxRepresentativeParty !=''">
									<b>
										<xsl:value-of select="fcn:LabelName('BG-11', 'true')"/>
									</b>
									<br/>
									<xsl:apply-templates select="cac:TaxRepresentativeParty"/>
								</xsl:if>
								
								<xsl:apply-templates select="cac:Delivery" mode="DocumentHeader"/>
							</td>
						</tr>
					</xsl:if>
					<!-- Any additional information on document level or referenced/attached documents: -->
					<xsl:if test="cbc:Note[.!=''] or cac:ContractDocumentReference !='' or cac:AdditionalDocumentReference !=''or cac:BillingReference !=''">
						<tr>
							<td colspan="8">
								<hr size="2"/>
							</td>
						</tr>
						<tr>
							<td valign="top" colspan="4">
								<xsl:if test="cbc:Note[.!='']">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-22', 'true')"/>
									</b>
									<br/>
									<xsl:apply-templates select="cbc:Note"/>
								</xsl:if>
							</td>
							<td valign="top" colspan="4">
								<xsl:if test="cac:ContractDocumentReference !=''">
									<b>
										<xsl:value-of select="fcn:LabelName('BT-12', 'true')"/>
									</b>
									<xsl:apply-templates select="cac:ContractDocumentReference"/>
								</xsl:if>
								<xsl:if test="cac:AdditionalDocumentReference !=''">
									<xsl:if test="cac:ContractDocumentReference !=''">
										<br/>
									</xsl:if>
									<b>
										<xsl:value-of select="fcn:LabelName('BG-24', 'true')"/>
									</b>
									<xsl:apply-templates select="cac:AdditionalDocumentReference"/>
								</xsl:if>
							</td>
						</tr>
					</xsl:if>
					<!-- Allowances and charges on document level: -->
					<xsl:if test="cac:AllowanceCharge !='' ">
						<tr>
							<td colspan="8">
								<hr size="2"/>
							</td>
						</tr>
						<tr>
							<td colspan="8">
								<b>
									<xsl:value-of select="fcn:LabelName('BG-20', 'true')"/>
								</b>
							</td>
						</tr>
						<tr>
							<td valign="top" colspan="2">
								<b>
									<xsl:value-of select="fcn:LabelName('BG-21', 'true')"/>
								</b>
							</td>
							<td valign="top" colspan="2">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-98', 'true')"/>
								</b>
							</td>
							<td valign="top" colspan="2">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-104', 'true')"/>
								</b>
							</td>
							<td valign="top">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-95', 'true')"/>
								</b>
							</td>
							<td valign="top" align="right">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-99', 'true')"/>
								</b>
							</td>
						</tr>
						<xsl:apply-templates select="cac:AllowanceCharge" mode="DocumentLevel-new"/>
					</xsl:if>
					<!-- End of invoice header -->
					<!-- Start tax totals: -->
					<tr>
						<td colspan="8">
							<hr size="2"/>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="2">
							<b>
								<xsl:value-of select="fcn:LabelName('BG-23', 'true')"/>
							</b>
						</td>
						<td valign="top" colspan="2">
							<xsl:if test="cbc:TaxPointDate !=''">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-7', 'true')"/>
								</b>

								&#160;<xsl:value-of select="cbc:TaxPointDate"/>
							</xsl:if>
						</td>
						<td valign="top" colspan="4">
							<xsl:if test="cbc:TaxCurrencyCode !=''">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-6', 'true')"/>
								</b>
								<xsl:value-of select="cbc:TaxCurrencyCode"/>
							</xsl:if>
						</td>
					</tr>
					<xsl:if test="cac:TaxTotal">
						<tr class="TAXInformationHeader">
							<td valign="top" colspan="2">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-118', 'false')"/>
								</b>
							</td>
							<td valign="top" colspan="2">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-120', 'false')"/>
								</b>
							</td>
							<td valign="top" colspan="2">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-116', 'false')"/>
								</b>
							</td>
							<td valign="top" align="right">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-111', 'false')"/>
								</b>
							</td>
							<td valign="top" align="right">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-117', 'false')"/>
								</b>
							</td>
						</tr>
						<xsl:apply-templates select="cac:TaxTotal/cac:TaxSubtotal"/>
					</xsl:if>
					<!--End document taxes -->
					<!-- Start document totals: -->
					<tr>
						<td colspan="8">
							<hr size="2"/>
						</td>
					</tr>
					<!-- Fix document totals -->
					<tr>
						<td valign="top" colspan="7">
							<b>
								<xsl:value-of select="fcn:LabelName('BG-22', 'true')"/>
							</b>
						</td>
						<td valign="top" align="right">
							<xsl:if test="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount !='' ">
								<small>
									<b>
										<xsl:value-of select="fcn:LabelName('BT-114', 'true')"/>
									</b>
									<br/>
									<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount"/>
								&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount/@currencyID"/>
								</small>
							</xsl:if>
						</td>
					</tr>
					<xsl:apply-templates select="cac:LegalMonetaryTotal" mode="New"/>
					<!-- Start on PAYMENT TERMS information -->
					<tr>
						<td colspan="8">
							<hr size="2"/>
						</td>
					</tr>
					<xsl:if test="cac:PaymentTerms !=''">
						<tr>
							<td valign="top">
								<b>
									<xsl:value-of select="fcn:LabelName('BT-20', 'true')"/>
								</b>
							</td>
							<td valign="top" colspan="7">
								<table>
									<xsl:apply-templates select="cac:PaymentTerms"/>
								</table>
							</td>
						</tr>
					</xsl:if>
					<!-- End of PAYMENT TERMS information -->
					<!-- Start on PAYMENT MEANS information -->
					<tr>
						<td valign="top">
							<b>
								<xsl:value-of select="fcn:LabelName('BG-16', 'true')"/>
							</b>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-81', 'true')"/>
							</b>&#160;&#160;
 
						</td>
						<td valign="top">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-86', 'true')"/>
							</b>
						</td>
						<td valign="top" colspan="2">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-84', 'true')"/>
							</b>
						</td>
						<td valign="top" colspan="2">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-86', 'true')"/>
							</b>
						</td>
						<td valign="top" colspan="1">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-83', 'true')"/>
							</b>
						</td>
						<td valign="top" align="right">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-9', 'true')"/>
							</b>
						</td>
					</tr>
					<xsl:apply-templates select="cac:PaymentMeans"/>
					<!-- End of PAYMENT MEANS information -->
				</table>
				<!--Start Credit Note line-->
				<table border="0" width="100%" cellspacing="0" cellpadding="2">
					<tr>
						<td colspan="9">
							<hr size="2"/>
						</td>
					</tr>
					<tr class="UBLInvoiceLineHeader">
						<td valign="top">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-126', 'true')"/>
							</b>
						</td>
						<td valign="top">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-155', 'true')"/>
							</b>
						</td>
						<td valign="top">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-153', 'true')"/>
							</b>
						</td>
						<td valign="top" align="right">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-129', 'true')"/>
							</b>
						</td>
						<td valign="top">
							<b>
								<!--xsl:value-of select="fcn:LabelName('NA', 'true')"/   ##QuantityUnitCode##-->
							</b>
						</td>
						<td valign="top">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-146', 'true')"/>
							</b>
						</td>
						<td valign="top">
							<b>
								<!--xsl:value-of select="fcn:LabelName('BT-6', 'true')"/   ##LineTaxDetails##-->
							</b>
						</td>
						<td valign="top">
							<b>
								<!--xsl:value-of select="fcn:LabelName('NA', 'true')"/   ##AllowanceCharge(Line)##-->
							</b>
						</td>
						<td align="right" valign="top">
							<b>
								<xsl:value-of select="fcn:LabelName('BT-131', 'true')"/>
							</b>
						</td>
					</tr>
					<xsl:apply-templates select="cac:CreditNoteLine"/>
				</table>
				<!--End Credit Note line-->
				<!-- Start on technical stylesheet footer - for all transactions -->
				<table border="0" width="100%" cellspacing="0" cellpadding="2">
					<tr>
						<td>
							<hr size="8"/>
						</td>
					</tr>
					<tr>
						<td>
							<small>
								<b>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TechFooter1']"/>
								</b>
								<br/>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TechFooter2']"/>
 									&#160;<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PEPPOLCreditNote']"/>
									&#160;<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TechFooter3']"/>
								<br/>
								<b>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TechFooter4']"/>
									<br/>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='VersionID']"/>
								</b>
								&#160;<xsl:value-of select="cbc:UBLVersionID"/>
								<br/>
								<!-- Verify profile and transaction combinations: -->
								<b>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ProfileName']"/>
								</b>&#160;
				 				<xsl:choose>
									<xsl:when test="cbc:ProfileID ='urn:www.cenbii.eu:profile:bii04:ver2.0' ">
										<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ProfileBIS4a']"/>
										<xsl:if test="cbc:CustomizationID !='urn:www.cenbii.eu:transaction:biitrns010:ver2.0:extended:urn:www.peppol.eu:bis:peppol4a:ver2.0' ">
											&#160;<em>
												<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='Profile-TransUnknown']"/>
											</em>
										</xsl:if>
									</xsl:when>
									<xsl:when test="cbc:ProfileID ='urn:www.cenbii.eu:profile:bii05:ver2.0' ">
										<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ProfileBIS5a']"/>
										<xsl:if test="cbc:CustomizationID !='urn:www.cenbii.eu:transaction:biitrns010:ver2.0:extended:urn:www.peppol.eu:bis:peppol5a:ver2.0' and 

											      cbc:CustomizationID !='urn:www.cenbii.eu:transaction:biitrns014:ver2.0:extended:urn:www.peppol.eu:bis:peppol5a:ver2.0'">
											&#160;<em>
												<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='Profile-TransUnknown']"/>
											</em>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<em>
											<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ProfileUnknown']"/>
										</em>
									</xsl:otherwise>
								</xsl:choose>
								<br/>
								<b>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ProfileID']"/>
								</b>
								&#160;<xsl:value-of select="cbc:ProfileID"/>
								<b>
									<br/>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='CustomizationID']"/>
								</b>
								&#160;<xsl:value-of select="cbc:CustomizationID"/>
								<xsl:if test="cbc:UUID !=''">
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='UUID']"/>&#160;<xsl:value-of select="cbc:UUID"/>
									<br/>
								</xsl:if>
							</small>
						</td>
					</tr>
					<tr>
						<td>
							<hr size="8"/>
						</td>
					</tr>
				</table>
				<!-- End of technical stylesheet footer-->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
