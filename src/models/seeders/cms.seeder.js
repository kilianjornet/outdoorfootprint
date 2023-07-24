var CmsPage = require('../cms.model');

module.exports = async () => {
    let count = await CmsPage.model.estimatedDocumentCount().exec();
    if (!count) {
        await CmsPage.model.create([
            {
                name: 'privacy-policy',
                content: "<p>Our mobile application, Outdoor Carbon Footprint Calculator, values your privacy and is committed to protecting your personal information. When you use our app, we may collect certain data including your name, email address, and location to offer a personalized experience and accurate carbon footprint calculations. We also gather non-personal information like device details and usage data to enhance app functionality and performance.</p>",
                title: 'Privacy Policy'
            }, {
                name: 'terms',
                content: "<p>By downloading, installing, and using the Outdoor Carbon Footprint Calculator mobile application, you agree to comply with the following terms and conditions. The application is provided on an as is basis, and we do not guarantee its accuracy, reliability, or suitability for your specific needs. While we make every effort to provide accurate carbon footprint calculations, we disclaim any responsibility for the results obtained through the use of our application.</p>",
                title: 'Terms & Conditions for Customers'
            },
            //  {
            //     name: 'faq',
            //     content: "<p>FAQ</p>",
            //     title: 'Fequently Asked Questions'
            // }, {
            //     name: 'welcome-message-customer',
            //     content: "Welcome",
            //     title: 'Customer Welcome Message'
            // }, {
            //     name: 'contact',
            //     content: "<p>Contact Us</p>",
            //     title: 'Contact Us'
            // }
        ])
    }
    return true;
}