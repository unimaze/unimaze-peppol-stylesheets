# USAGE AND CUSTOMIZATION

## Adding a new language
In order to add another language to the stylesheet, there are a few steps.

`*` is your language code

Create a file named Headlines-BT_&ast;.xml (or copy and rename Headlines-BT_en.xml)
The structure of the xml should be:

`<Semantic Model>`<br/>
	&nbsp; &nbsp; `<BusinessTerm id= "BT or BG code">`<br/>
		&nbsp; &nbsp; &nbsp;&nbsp;  `<TermName> The official term name in your language </Termname>`<br/>
		&nbsp; &nbsp; &nbsp; &nbsp; `<Definition> The definition of the term </Definition> --->Optional`<br/>
		&nbsp; &nbsp; &nbsp; &nbsp; `<Description> A description of the term </Description> --->Optional`<br/>
		&nbsp; &nbsp; &nbsp; &nbsp; `<DisplayName> The preferred display name in the stylesheet (if abscent, the TermName will be used) - If present 
		but empty, no lead text will be shown in the stylesheet.` <br/>
	&nbsp; &nbsp; &nbsp; &nbsp; `</DisplayName> --> Optional`<br/>
	&nbsp; &nbsp; `</BusinessTerm>`<br/>
`</Semantic Model>`<br/>

Pleas make sure to add all the BusinessTerms you wish to be visible in the stylesheet, there is no fallback if a term is missing, the lead text will then be abscent.

Create files corresponding to all the relevant code lists in your language by replacing the * with your language code. 
With these code lists, there will be a fallback to english code values if the value is missing in your language.

The format of all of the code lists below are in generic code 1.0 : http://docs.oasis-open.org/codelist/ns/genericode/1.0/

The relevant code lists are:

* UBLClassificationCode_&ast;.xml --> Item classification identifier
* UBLInvoiceBaseType_&ast;.xml --> Base type of document: Invoice or Credit Note
* UBLPeriodDescriptionCode_&ast;.xml --> Invoice period description code
* UBLTaxCategoryCode_&ast;.xml --> Tax category code
* UNCL1001_&ast;.xml --> Sub-type of document
* UNCL4461_&ast;.xml --> Payment means code
* UNCL5189_&ast;.xml --> Allowance reason code
* UNCL7161_&ast;.xml --> Charge reason code
* UNECE_&ast;.xml --> Unit of measure code

## Setting the default language
Open the user_config.xsl and under the tag: `<xsl:variable name="lang" select="'*'"/>` change the `*` to your language code, corresponding to the `*` in your file names.

The language can be changed in runtime by setting the `lang` XSLT parameter when invoking the transaction.
