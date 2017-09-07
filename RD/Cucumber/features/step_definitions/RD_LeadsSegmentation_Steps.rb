#enconding: utf-8

$add_segmentation = '1_test_Segmentation'
$edit_segmentation = '2_test_Segmentation'
$search_key = 'test'
$duplicated = ' - Duplicado'

def validateSegmentationPage
	button_text = @driver.find_element(:css, 'button[type="button"]').text
	button_text.should == "Criar Segmentação"
end

def validateSegmentationName (title = nil)
	@driver.find_elements(:xpath => "//*[@id='table-segmentationlist-index']/tbody/tr/td[1]").each do 
		|r|
		if (r.text == $add_segmentation) or (r.text == $edit_segmentation) 
			segmentation_found = "ok"
			break if segmentation_found.should == "ok"
		elseif (title == "duplicado")
			break if (r.text == $add_segmentation + $duplicated) or (r.text == $edit_segmentation + $duplicated) 
		end		
	end	
end

Given(/^I access the RDStation site$/) do
	#@driver = Selenium::WebDriver.for :firefox
	@driver.manage.window.maximize
	@driver.manage.timeouts.implicit_wait = 5
	@driver.get 'https://app-staging.rdstation.com.br/login'
end

Given(/^I login in with a valid user$/) do
	@driver.find_element(:id, 'user_email').send_keys('teste@testefernanda.com')
	@driver.find_element(:id, 'user_password').send_keys('senha123456')
	@driver.find_element(:css, 'input[type="submit"]').click
	sleep 5
end

Given(/^I am in Segmentation Leads page$/) do
	validateSegmentationPage
end

Given(/^I already have a segmentation created$/) do
	validateSegmentationName @add_segmentation
end

When(/^I access the RDStation Segmentation Leads page$/) do
	@driver.find_element(:xpath, '//*[@id="relate-menu"]/a').click
	@driver.find_element(:xpath, '//*[@id="relate-menu"]/ul/li[5]/a').click
	sleep 5
end

When(/^I fill the segmentation name field$/) do
	@driver.switch_to.active_element
	@driver.find_element(:id, 'segmentation_name').send_keys($add_segmentation)
	@driver.action.send_keys("\n").perform
	sleep 5
end

When(/^I fill the condition field term$/) do
	@driver.find_element(:xpath, '//*[@id="content"]/div[1]/form/div[3]/div/div[1]/div[2]/div/div[1]/div[5]/input').send_keys('test_Lead')	
end

When(/^I click on "([^"]*)" button$/) do |button|
	if button == "Criar Segmentação"
		@driver.find_element(:css, 'button[type="button"]').click
	end
	if button == "Salvar"
		@driver.find_element(:id, 'save-segmentation').click
	end
	if button == "Editar"
		@driver.find_element(:xpath, '//*[@id="table-segmentationlist-index"]/tbody/tr[1]/td[2]/a').click
	end	
	if button == "Mostrar Leads"
		@driver.find_element(:xpath, '//*[@id="table-segmentationlist-index"]/tbody/tr[1]/td[2]/div/a').click
	end
	if button == "Duplicar"
		@driver.find_element(:xpath, '//*[@id="table-segmentationlist-index"]/tbody/tr[1]/td[2]/div/button').click
		@driver.find_element(:xpath, '//*[@id="table-segmentationlist-index"]/tbody/tr[1]/td[2]/div/ul/li[2]/a').click		
	end
	sleep 5  
end

When(/^I edit the Segmentation field$/) do
	@driver.find_element(:id, 'segmentation_list_name').clear
	@driver.find_element(:id, 'segmentation_list_name').send_keys($edit_segmentation)
end

When(/^I fill the search field wtih a valid segmentation name$/) do
	@driver.find_element(:css, 'input[type="search"]').send_keys($search_key)
end

Then(/^I should be able to see the Segmentation Leads page$/) do
	validateSegmentationPage
end

Then(/^the segmentation created should be displayed in the list$/) do
	validateSegmentationName $add_segmentation
end

Then(/^the segmentation should be edited$/) do
	validateSegmentationName $edit_segmentation
end

Then(/^the list should displays just segmentation with word searched$/) do
	validateSegmentationName 
end

Then(/^the leads page should be displayed$/) do
	text_page = @driver.find_element(:xpath, '//*[@id="page-header"]/h1').text
	text_page.should == "Base de Leads"
end

Then(/^the segmentation should be duplicated$/) do
	validateSegmentationName "duplicado"
end