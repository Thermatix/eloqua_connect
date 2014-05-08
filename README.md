Eloqua Connect
==============

#<b>This gem has been abandonded, use at your own risk<b>

Eloqua Connect is a mechanism to push and pull data to eloqua but with model like mechanism for doing so. For example:

    contact = Contact.new(contact_hash)
    contact.someField = "information"
    if contact.save
      #do something if save is successful
    else
      #do something if save is not successful
    end

That is an example of how you would save and modify data, just like you would a traditional rails model.

Setting up the models
---------------------

The first thing you have to do is configure the gem. Create an initializer file (in the config directory if in rails)
in the initializer folder and copy and paste the following into the top:

    require 'eloqua_connect'
    include EloquaConnect::ContactFields

The first loads the gem, the second gives you access to the data fields, that you can use to store data in.

This is an example config:

    EloquaConnect.configure do |config|
      config.company = 'massiveSoft_ltd'
      config.username = 'Joe_Blogs'
      config.password = '1some2awesome3pasword'
      config.models = [
                      EloquaConnect::ModelSetup.new do |mod|
                        mod.fields = [
                          FIELDS[:emailAddress],
                          FIELDS[:firstName],
                          FIELDS[:lastName],
                          FIELDS[:paypalAccountId],
                          FIELDS[:territory],
                          FIELDS[:leadSourceOriginal]
                          ]
                        mod.modelName = "PayPalToEloqua"
                        mod.modelType = "contact"
                      end
                      ]
    end

The first three config options are self explanatory, models is where you pass the model setup objects.
You need to pass a ModelSetup object for every eloqua model you intend to use.

The first thing you can pass are the fields you intend to use which are pulled from the 'FIELDS' constant, the full list of available fields will be at the bottom of this readme.

The next is the model name, this will be used to match it to the model class, it needs to be spelt exactly as the class name is spelt.

The last thing is the model Type, for the moment, Eloqua connect only supports the saving and pulling of contact data.

Since Models using Eloqua Connect don't use Active model, it's better to place them into the lib directory of your rails directory and then require that model in the controller you are using it in, that way you keep them separate from any Active Model based models.

The model file is simple to setup, the example is as follows:

    class PayPalToEloqua < EloquaConnect::Model

    end

The model needs to named **EXACTLY** as it's spelt, capitals in the exact same places as in the model name for the model setup object you're trying to match it to, if you don't it won't match up properly.

You can now use it as you would any other model object.

for example:

    @user = PayPalToEloqua.new(user_params)
    @user.save

Remember, the params need to match the symbols you are using in the fields, ie if you are using

    FIELDS[:leadSourceOriginal]

then in the hash you pass to the new object would use:

    { leadSourceOriginal: 'some data' }

The same goes for accessing the data

    @user.leadSourceOriginal = 'some data'
    variable = @user.leadSourceOriginal


Field Listing
-------------
field name : field symbol to use when in config

    Email Address : emailAddress
    First Name : firstName
    Last Name : lastName
    Company : company
    Email Display Name : emailDisplayName
    Address 1 : address1
    Address 2 : address2
    Address 3 : address3
    City : city
    State or Province : stateOrProvince
    Zip or Postal Code : zipOrPostalCode
    Country : country
    Business Phone : businessPhone
    Mobile Phone : mobilePhone
    Fax : fax
    Title : title
    Salutation : salutation
    Salesperson : salesperson
    SFDC ContactID : sfdcContactid
    SFDC LeadID : sfdcLeadid
    Date Created : dateCreated
    Date Modified : dateModified
    Eloqua Contact ID : eloquaContactId
    SFDC AccountID : sfdcAccountid
    Last Modified by CRM System : lastModifiedByCrmSystem
    Last SFDC Campaign ID : lastSfdcCampaignId
    Last SFDC Campaign Status : lastSfdcCampaignStatus
    Company Revenue : companyRevenue
    SFDC EmailOptOut : sfdcEmailoptout
    Lead Source - Most Recent : leadSourceMostRecent
    Lead Source - Original : leadSourceOriginal
    Industry : industry
    Estimated Annual Sales : estimatedAnnualSales
    Lead Status : leadStatus
    Job Role : jobRole
    Lead Score - High Value Website Content : leadScoreHighValueWebsiteContent
    Lead Score Date - Engagement - Most Recent : leadScoreDateEngagementMostRecent
    Integrated Marketing and Sales Funnel Stage : integratedMarketingAndSalesFunnelStage
    Primary Solution of Interest : primarySolutionOfInterest
    Region : region
    PURL Name (Default Hypersite) : purlName_DH_
    Lead Rating - Combined : leadRatingCombined
    Email Address Domain : emailAddressDomain
    First and Last Name : firstAndLastName
    Company Size : companySize
    Lead Score - Last High Touch Event Date : leadScoreLastHighTouchEventDate
    Lead Rating - Profile (Explicit) : leadRatingProfile_E_
    Lead Rating - Engagement (Implicit) : leadRatingEngagement_I_
    Lead Score - Profile (Explicit) : leadScoreProfile_E_
    Lead Score - Engagement (Implicit) : leadScoreEngagement_I_
    Lead Score Date - Profile - Most Recent : leadScoreDateProfileMostRecent
    PURL Name : purlName
    Lead Score (deprecated) : leadScore_D_
    Last SFDC Campaign Name1 : lastSfdcCampaignName1
    SFDC Lead Rating : sfdcLeadRating
    Discover Most Recent Activity Date : discoverMostRecentActivityDate
    Discover Total Inbound Activity : discoverTotalInboundActivity
    Discover Lead Buy Signals : discoverLeadBuySignals
    Do you have a website? : doYouHaveAWebsite?
    Website Address : websiteAddress
    eCommerce Platform : ecommercePlatform
    Trading Bank : tradingBank
    Why are you contacting us? : whyAreYouContactingUs?
    SFDC Lead Record Type : sfdcLeadRecordType
    Number of Full Time Employees : numberOfFullTimeEmployees
    Department : department
    Description : description
    Webform URL : webformUrl
    Opt out of Emails : optOutOfEmails
    Organisational Role : organisationalRole
    Do you currently have a PayPal Account : doYouCurrentlyHaveAPaypalAccount
    Current Payment Methods : currentPaymentMethods
    Annual Online Sales : annualOnlineSales
    Estimate of Any Offline Volume : estimateOfAnyOfflineVolume
    Website Launch Date : websiteLaunchDate
    Inbound / Outbound : inbound__Outbound
    SFDC Contact Record Type : sfdcContactRecordType
    Territory : territory
    Target Product : targetProduct
    IP_Warming_Contact? : ipWarmingContact?
    Chamber of Commerce Registration Number : chamberOfCommerceRegistrationNumber
    Company registration number : companyRegistrationNumber
    What will you use PayPal for? : whatWillYouUsePaypalFor?
    Do you use an external shopping-cart system : doYouUseAnExternalShoppingCartSystem
    Avg Monthly Volume : avgMonthlyVolume
    External Carts : externalCarts
    Additional Comments : additionalComments
    Customer ID : customerId
    Plan to use E-Commerce Partner? : planToUseECommercePartner?
    Timeline for Services : timelineForServices
    Cart List : cartList
    Converted : converted
    Lead ID : leadId
    Opportunity : opportunity
    PayPal Account ID : paypalAccountId
    Do you plan to create a website? : doYouPlanToCreateAWebsite?
    Name Analyser - Validation Results : nameAnalyserValidationResults
    Name Analyser - Gender Results : nameAnalyserGenderResults
    Business Phone Type : businessPhoneType
    Business Category : businessCategory
    I'm Interested In : imInterestedIn
    Other Business Phone Type : otherBusinessPhoneType
    Other Business Category : otherBusinessCategory
    Visited From : visitedFrom
    Partner Lead ID : partnerLeadId
    Random_Number : randomNumber
    FirstName-Email : firstnameEmail
    SFDC Lead Owner ID : sfdcLeadOwnerId
    Opt in (email + phone) : optIn_EP_
    Originally Created By : originallyCreatedBy
    Current POS System : currentPosSystem
    LeadNurture 2.0 Data form stage : leadnurture2_0DataFormStage
    CLS - Region : clsRegion
    CLS - Business Unit : clsBusinessUnit
    Hot : hot
    Reason for Contact : reasonForContact
    Type of Enquiry : typeOfEnquiry
    Last SFDC Campaign Member ID : lastSfdcCampaignMemberId
    Twitter ID : twitterId
    Contact Type : contactType




