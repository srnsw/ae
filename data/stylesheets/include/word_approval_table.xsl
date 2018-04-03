<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="approval_table">
		<w:tbl>
			<w:tblPr>
				<w:tblW w:type="auto" w:w="0"/>
				<w:tblLayout w:type="Fixed"/>
			</w:tblPr>
			<w:tblGrid>
				<w:gridCol w:w="3085"/>
				<w:gridCol w:w="5103"/>
				<w:gridCol w:w="1099"/>
			</w:tblGrid>
			<w:tr>
				<w:trPr>
					<w:trHeight w:val="555"/>
				</w:trPr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:vmerge w:val="restart"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Heading2"/>
						</w:pPr>
						<w:r>
							<w:t>Approved for Submission to the Board</w:t>
						</w:r>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="6202"/>
						<w:gridSpan w:val="2"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:trPr>
					<w:trHeight w:val="555"/>
				</w:trPr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:vmerge/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Heading2"/>
						</w:pPr>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="6202"/>
						<w:gridSpan w:val="2"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:trPr>
					<w:trHeight w:val="555"/>
				</w:trPr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:vmerge/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Heading2"/>
						</w:pPr>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="5103"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:r>
							<w:t><xsl:value-of select="$MANAGER"/></w:t>
						</w:r>
						<w:r>
							<w:br w:clear="all" w:type="text-wrapping"/>
						</w:r>
						<w:r>
							<w:t>
								<xsl:value-of select="$MANAGER_ROLE"/>
							</w:t>
						</w:r>
						<w:r>
							<w:br/>
							<w:t>
								<xsl:value-of select="$ORG_SHORT"/>
							</w:t>
						</w:r>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="1099"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:r>
							<w:t>Date</w:t>
						</w:r>
					</w:p>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:trPr>
					<w:trHeight w:val="555"/>
				</w:trPr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Heading2"/>
						</w:pPr>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="5103"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="1099"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:vmerge w:val="restart"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Heading2"/>
						</w:pPr>
						<w:r>
							<w:t>Approved by the Board</w:t>
						</w:r>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="6202"/>
						<w:gridSpan w:val="2"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:vmerge/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Heading2"/>
						</w:pPr>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="6202"/>
						<w:gridSpan w:val="2"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:vmerge/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="5103"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Normalsingle"/>
							<w:tabs>
								<w:tab w:pos="5987" w:val="left"/>
							</w:tabs>
							<w:spacing w:after="120" w:before="120"/>
						</w:pPr>
						<w:r>
							<w:t><xsl:value-of select="$CHAIR"/></w:t>
						</w:r>
						<w:r>
							<w:br w:clear="all" w:type="text-wrapping"/>
							<w:t>
								<xsl:value-of select="$CHAIR_ROLE"/>
							</w:t>
						</w:r>
						<w:r>
							<w:tab/>
						</w:r>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="1099"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Normalsingle"/>
							<w:tabs>
								<w:tab w:pos="5987" w:val="left"/>
							</w:tabs>
							<w:spacing w:after="120" w:before="120"/>
						</w:pPr>
						<w:r>
							<w:t>Date</w:t>
						</w:r>
					</w:p>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="5103"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Normalsingle"/>
							<w:tabs>
								<w:tab w:pos="5987" w:val="left"/>
							</w:tabs>
							<w:spacing w:after="120" w:before="120"/>
						</w:pPr>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="1099"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Normalsingle"/>
							<w:tabs>
								<w:tab w:pos="5987" w:val="left"/>
							</w:tabs>
							<w:spacing w:after="120" w:before="120"/>
						</w:pPr>
					</w:p>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:vmerge w:val="restart"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Heading2"/>
						</w:pPr>
						<w:r>
							<w:t>Approved for Issue</w:t>
						</w:r>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="6202"/>
						<w:gridSpan w:val="2"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:vmerge/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Heading2"/>
						</w:pPr>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="6202"/>
						<w:gridSpan w:val="2"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
			</w:tr>
			<w:tr>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="3085"/>
						<w:vmerge/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p/>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="5103"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Normalsingle"/>
							<w:tabs>
								<w:tab w:pos="5987" w:val="left"/>
							</w:tabs>
							<w:spacing w:after="120" w:before="120"/>
						</w:pPr>
						<w:r>
							<w:t><xsl:value-of select="$DIRECTOR"/></w:t>
						</w:r>
						<w:r>
							<w:br w:clear="all" w:type="text-wrapping"/>
							<w:t><xsl:value-of select="$DIRECTOR_ROLE"/></w:t>
						</w:r>
						<w:r>
							<w:br/>
							<w:t><xsl:value-of select="$ORG_SHORT"/></w:t>
						</w:r>
						<w:r>
							<w:tab/>
						</w:r>
					</w:p>
				</w:tc>
				<w:tc>
					<w:tcPr>
						<w:tcW w:type="dxa" w:w="1099"/>
						<w:shd w:color="auto" w:fill="auto" w:val="clear"/>
					</w:tcPr>
					<w:p>
						<w:pPr>
							<w:pStyle w:val="Normalsingle"/>
							<w:tabs>
								<w:tab w:pos="5987" w:val="left"/>
							</w:tabs>
							<w:spacing w:after="120" w:before="120"/>
						</w:pPr>
						<w:r>
							<w:t>Date</w:t>
						</w:r>
					</w:p>
				</w:tc>
			</w:tr>
		</w:tbl>
	</xsl:template>
</xsl:stylesheet>