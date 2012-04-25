/*
   Copyright 2012, Simon Bingham

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

component accessors="true" 
{
	
	/*
	 * Properties
	 */	
	
	property name="metatitle";
	property name="metakeywords";
	property name="metadescription";

	/*
	 * Public methods
	 */
	 	
	function init()
	{
		variables.metatitle = "";
		variables.metakeywords = "";
		variables.metadescription = "";
		return this;
	}
	
	string function generateMetaKeywords( required string keywords )
	{
		return Left( Trim( listDeleteDuplicatesNoCase( ListChangeDelims( metaExclude( arguments.keywords ), ",", " ." ) ) ), 200 );
	}
	
	string function generateMetaDescription( required string description )
	{
		return Left( Trim( REReplaceNoCase( REReplaceNoCase( stripHTML( arguments.description ), "([#Chr(09)#-#Chr(30)#])", " ", "all" ), "( ){2,}", " ", "all" ) ), 200 );
	}
	
	string function stripHTML( required string thestring ) {
		return REReplaceNoCase( Trim( arguments.thestring ), "<[^>]{1,}>", " ", "all" );
	}

	/*
	 * Private methods
	 */

	private string function metaExclude( required string thestring ) {
		return Trim( REReplaceNoCase(" " & REReplace( stripHTML( arguments.thestring ), "[ *]{1,}", "  ", "all"), "[ ]{1}(a|an|and|is|it|that|the|this|to|or)[ ]{1}", " ", "all" ) );
	}
	
	private string function listDeleteDuplicatesNoCase( required string list ) {
		var local = StructNew();
		if( ArrayLen( arguments ) eq 2 ) local.delimiter = arguments[ 2 ];
		else local.delimiter = ",";
		local.elements = ListToArray( arguments.list, local.delimiter );
		local.listnoduplicates = "";
		for( local.i=1; local.i lte ArrayLen( local.elements ); local.i=local.i+1 ) 
		{
			if( !ListFindNoCase( local.listnoduplicates, local.elements[ local.i ], local.delimiter ) )
			{
				if( Len( local.listnoduplicates ) ) local.listnoduplicates = local.listnoduplicates & local.delimiter & local.elements[ local.i ];
				else local.listnoduplicates = local.elements[ local.i ];
			}
		}
		return Trim( local.listnoduplicates );
	}
	
}