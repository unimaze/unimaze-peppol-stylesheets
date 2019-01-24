Readme:

In order to add another language to the stylesheet, there are a few steps.

* is your languagecode

Create a file named Headlines-BT_*.xml (or copy and rename Headlines-BT_en.xml)
The structure of the xml should be:

<Semantic Model>
	<BusinessTerm id= "BT or BG code">
		<TermName> The official term name in your language </Termname>
		<Definition> The definition of the term </Definition> --->Optional
		<Description> A description of the term </Description> --->Optional
		<DisplayName> The preferred display name in the stylesheet (if abscent, the TermName will be used) - If present but empty, no lead text will be shown in the stylesheet. </DisplayName> --> Optional
	</BusinessTerm>
</Semantic Model>

Pleas make sure to add all the BusinessTerms you wish to be visible in the stylesheet, there is no fallback if a term is missing, the lead text will then be abscent.

Create files corresponding to all the relevant code lists in your language by replacing the * with your language code. 
With these code-lists, there will be a fallback to english code values if the value is missing in your language.

The format of all of the code lists below are in generic code 1.0 : http://docs.oasis-open.org/codelist/ns/genericode/1.0/

The relevant code lists are:

UBLClassificationCode_*.xml --> Item Classification Identifier
UBLInvoiceBaseType_*.xml --> Base type of document: Invoice or Credit Note
UBLPeriodDescriptionCode_*.xml --> Invoice period description code
UBLTaxCategoryCode_*.xml --> Tax category code
UNCL1001_*.xml --> Subtype of document
UNCL4461_*.xml --> Payment means code
UNCL5189_*.xml --> Allowance reason code
UNCL7161_*.xml --> Charge reason code
UNECE_*.xml --> Unit of measure code


Finally, open the user.config.xsl and under the tag: <xsl:variable name="lang" select="'*'"/> change the * to your language code, correspondign to the * in your file names.