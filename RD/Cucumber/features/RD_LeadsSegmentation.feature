Feature: RD - Leads Segmentation
	In RDStation page
	As a RDStation user
	I should be able to create a segmentation
	So I can manage it 

Background:
	Given I access the RDStation site
	And I login in with a valid user
	When I access the RDStation Segmentation Leads page
	Then I should be able to see the Segmentation Leads page

Scenario: Create a new segmentation
	Given I am in Segmentation Leads page
	When I click on "Criar Segmentação" button
	And I fill the segmentation name field
	And I click on "Criar Segmentação" button
	And I fill the condition field term
	And I click on "Salvar" button
	Then the segmentation created should be displayed in the list
	
Scenario: Edit the segmentation
	Given I am in Segmentation Leads page
	And I already have a segmentation created
	When I click on "Editar" button
	And I edit the Segmentation field
	And I click on "Salvar" button
	Then the segmentation should be edited
	
Scenario: Search by a segmentation
	Given I am in Segmentation Leads page
	And I already have a segmentation created
	When I fill the search field wtih a valid segmentation name
	Then the list should displays just segmentation with word searched
	
Scenario: Show the leads of a segmentation
	Given I am in Segmentation Leads page
	And I already have a segmentation created
	When I click on "Mostrar Leads" button
	Then the leads page should be displayed

Scenario: Duplicate the segmentation
	Given I am in Segmentation Leads page
	And I already have a segmentation created
	When I click on "Duplicar" button
	Then the segmentation should be duplicated
