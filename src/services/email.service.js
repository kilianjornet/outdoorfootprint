const nodemailer = require("nodemailer");
const config = require("../config/config");
const logger = require("../config/logger");
const userService = require("../services/user.service")

function generateCustomCode(count) {
  let dateTime = new Date().toISOString().replace(/[^\d]/g, "");
  let str = "0123456789" + dateTime;
  var chars = str.split("");
  var result = "";
  for (var i = 0; i < count; i++) {
    var x = Math.floor(Math.random() * chars.length);
    result += chars[x];
  }
  return result.toUpperCase();
}

const transport = nodemailer.createTransport(config.email.smtp);
/* istanbul ignore next */
if (config.env !== "test") {
  transport
    .verify()
    .then(() => logger.info("Connected to email server"))
    .catch(() =>
      logger.warn(
        "Unable to connect to email server. Make sure you have configured the SMTP options in .env"
      )
    );
}

/**
 * Send an email
 * @param {string} to
 * @param {string} subject
 * @param {string} text
 * @returns {Promise}
 */
const sendEmail = async (to, subject, text) => {
  const msg = { from: config.email.from, to, subject, text };
  try {
    await transport.sendMail(msg);
  } catch (e) {
    console.log("errrement:-----", e);
  }
};

/**
 * Send reset password email
 * @param {string} to
 * @param {string} token
 * @returns {Promise}
 */
const sendResetPasswordEmail = async (to, token) => {
  const subject = "Reset password";
  // replace this url with the link to the reset password page of your front-end app
  const resetPasswordUrl = `http://link-to-app/reset-password?token=${token}`;
  const text = `Dear user,
To reset your password, click on this link: ${resetPasswordUrl}
If you did not request any password resets, then ignore this email.`;
  await sendEmail(to, subject, text);
};

/**
 * Send verification email
 * @param {string} to
 * @param {string} token
 * @returns {Promise}
 */
const sendVerificationEmail = async (to, fullname,userId) => {
  const subject = "Email Verification";
  // replace this url with the link to the email verification page of your front-end app
  const otp = generateCustomCode(6);

  let mailOptions = {
    from: config.email.from,
    to: to,
    subject: subject,
    html: `<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tbody>
        <tr>
            <td align="center">
                <table class="col-600" width="600" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tbody><tr>
                        <td align="center" valign="top" background="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/email-bg.png" bgcolor="#66809b" style="background-size:cover; background-position:top;height=" 400""="">
                            <table class="col-600" width="600" height="250" border="0" align="center" cellpadding="0" cellspacing="0">

                                <tbody><tr>
                                    <td height="40"></td>
                                </tr>


                                <tr>
                                    <td align="center" style="line-height: 0px;">
                                        <img style="display:block; line-height:0px; font-size:0px; border:0px;" src="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/logo-dark-daebd0d0.png" width="250" height="80" alt="logo">
                                    </td>
                                </tr>

                                <tr>
                                    <td align="center" style="font-family: 'Raleway', sans-serif; font-size:20px; color:#ffffff; line-height:24px; font-weight: 300;">
                                        WORKING ON THE PRESERVATION OF THE MOUNTAIN ENVIRONMENT
                                    </td>
                                </tr>


                                <tr>
                                    <td height="50"></td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                </tbody></table>
            </td>
        </tr>
        <tr>
            <td align="center">
                <table class="col-600" width="600" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-left:20px; margin-right:20px; border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;">
                    <tbody>
                        <tr>
                            <td height="35"></td>
                        </tr>
                        <tr>
                            <td align="center" style="font-family: 'Raleway', sans-serif; font-size:22px; font-weight: bold; color:#2a3a4b;">OTP Verification</td>
                        </tr>
                        <tr>
                            <td height="5"></td>
                        </tr>
                        <tr>
                            <td align="center" style="font-family: 'Raleway', sans-serif; font-size:18px; font-weight: bold; color:#2a3a4b;">Hello, ${fullname}</td>
                        </tr>
                        <tr>
                            <td height="10"></td>
                        </tr>
                        <tr>
                            <td align="center" style="font-family: 'Lato', sans-serif; font-size:14px; color:#757575; line-height:24px; font-weight: 300;">
                                Please use the following OTP to verify your account:
                            </td>
                        </tr>
                        <tr>
                            <td height="5"></td>
                        </tr>
                        <tr>
                            <td align="center" style="font-family: 'Lato', sans-serif; font-size:14px; color:#757575; line-height:24px; font-weight: 300;">
                                <h2 style="display: inline-block; background: #00466a; margin: 0; padding: 10px 20px; color: #fff; border-radius: 4px;">${otp}</h2>
                            </td>
                        </tr>
                        <tr>
                            <td height="10"></td>
                        </tr>
                        <tr>
                            <td align="center" style="font-family: 'Lato', sans-serif; font-size:14px; color:#757575; line-height:24px; font-weight: 300;">
                                If you didn't request this OTP, you can ignore this email.<br>
                                Thank you!
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <table align="center" width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;">
                                    <tbody>
                                        <tr>
                                            <td height="50"></td>
                                        </tr>
                                        <tr>
                                            <td align="center" bgcolor="#34495e" background="#00466a" height="185">
                                                
                                                <table align="center" width="35%" border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" width="30%" style="vertical-align: top;">
                                                                    <a href="https://www.facebook.com/profile.php?id=100064541060004" target="_blank"> <img src="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/icons8-facebook-48.png"> </a>
                                                            </td>
                        
                                                            <td align="center" class="margin" width="30%" style="vertical-align: top;">
                                                                    <a href="https://www.instagram.com/kilianjornetfoundation/" target="_blank"> <img src="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/icons8-instagram-48.png"> </a>
                                                            </td>
                        
                                                            <td align="center" width="30%" style="vertical-align: top;">
                                                                    <a href="https://open.spotify.com/show/2v8mo7EQmFZo0GMq4Y8aFX?si=09b375baa3fd48a8&nd=1" target="_blank"> <img src="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/icons8-spotify-48.png"> </a>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table>`,
  };
  try {
    await transport.sendMail(mailOptions);
    const otpinsret = await userService.updateOtpUser(userId,otp);
    console.log("otpinsret:-----", otpinsret);
    return true;
  } catch (e) {
    console.log("errrement:-----", e);
    return false;
  }
  // transport.sendMail(mailOptions, function (err, info) {
  //   if (err) {
  //     console.log("er:------------------>", err);
  //     return true;
  //   } else {
  //     console.log("Mail resent: " + info.response);
  //     return false;
  //   }
  // });

  // await sendEmail(to, subject, text);
};
const sendForgotOtpEmail = async (to, fullname,userId) => {
    const subject = "Forgot Password Verification";
    // replace this url with the link to the email verification page of your front-end app
    const otp = generateCustomCode(6);
  
    let mailOptions = {
      from: config.email.from,
      to: to,
      subject: subject,
      html: `<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tbody>
          <tr>
              <td align="center">
                  <table class="col-600" width="600" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tbody><tr>
                          <td align="center" valign="top" background="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/email-bg.png" bgcolor="#66809b" style="background-size:cover; background-position:top;height=" 400""="">
                              <table class="col-600" width="600" height="250" border="0" align="center" cellpadding="0" cellspacing="0">
  
                                  <tbody><tr>
                                      <td height="40"></td>
                                  </tr>
  
  
                                  <tr>
                                      <td align="center" style="line-height: 0px;">
                                          <img style="display:block; line-height:0px; font-size:0px; border:0px;" src="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/logo-dark-daebd0d0.png" width="250" height="80" alt="logo">
                                      </td>
                                  </tr>
  
                                  <tr>
                                      <td align="center" style="font-family: 'Raleway', sans-serif; font-size:20px; color:#ffffff; line-height:24px; font-weight: 300;">
                                          WORKING ON THE PRESERVATION OF THE MOUNTAIN ENVIRONMENT
                                      </td>
                                  </tr>
  
  
                                  <tr>
                                      <td height="50"></td>
                                  </tr>
                              </tbody></table>
                          </td>
                      </tr>
                  </tbody></table>
              </td>
          </tr>
          <tr>
              <td align="center">
                  <table class="col-600" width="600" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-left:20px; margin-right:20px; border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;">
                      <tbody>
                          <tr>
                              <td height="35"></td>
                          </tr>
                          <tr>
                              <td align="center" style="font-family: 'Raleway', sans-serif; font-size:22px; font-weight: bold; color:#2a3a4b;">Forgot Password OTP Verification</td>
                          </tr>
                          <tr>
                              <td height="5"></td>
                          </tr>
                          <tr>
                              <td align="center" style="font-family: 'Raleway', sans-serif; font-size:18px; font-weight: bold; color:#2a3a4b;">Hello, ${fullname}</td>
                          </tr>
                          <tr>
                              <td height="10"></td>
                          </tr>
                          <tr>
                              <td align="center" style="font-family: 'Lato', sans-serif; font-size:14px; color:#757575; line-height:24px; font-weight: 300;">
                              Need to reset your password? Use your secret code!
                              </td>
                          </tr>
                          <tr>
                              <td height="5"></td>
                          </tr>
                          <tr>
                              <td align="center" style="font-family: 'Lato', sans-serif; font-size:14px; color:#757575; line-height:24px; font-weight: 300;">
                                  <h2 style="display: inline-block; background: #00466a; margin: 0; padding: 10px 20px; color: #fff; border-radius: 4px;">${otp}</h2>
                              </td>
                          </tr>
                          <tr>
                              <td height="10"></td>
                          </tr>
                          <tr>
                              <td align="center" style="font-family: 'Lato', sans-serif; font-size:14px; color:#757575; line-height:24px; font-weight: 300;">
                                  If you didn't request this OTP, you can ignore this email.<br>
                                  Thank you!
                              </td>
                          </tr>
                          <tr>
                              <td align="center">
                                  <table align="center" width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-left: 1px solid #dbd9d9; border-right: 1px solid #dbd9d9;">
                                      <tbody>
                                          <tr>
                                              <td height="50"></td>
                                          </tr>
                                          <tr>
                                              <td align="center" bgcolor="#34495e" background="#00466a" height="185">
                                                  
                                                  <table align="center" width="35%" border="0" cellspacing="0" cellpadding="0">
                                                      <tbody>
                                                          <tr>
                                                              <td align="center" width="30%" style="vertical-align: top;">
                                                                      <a href="https://www.facebook.com/profile.php?id=100064541060004" target="_blank"> <img src="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/icons8-facebook-48.png"> </a>
                                                              </td>
                          
                                                              <td align="center" class="margin" width="30%" style="vertical-align: top;">
                                                                      <a href="https://www.instagram.com/kilianjornetfoundation/" target="_blank"> <img src="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/icons8-instagram-48.png"> </a>
                                                              </td>
                          
                                                              <td align="center" width="30%" style="vertical-align: top;">
                                                                      <a href="https://open.spotify.com/show/2v8mo7EQmFZo0GMq4Y8aFX?si=09b375baa3fd48a8&nd=1" target="_blank"> <img src="https://nodeserver.mydevfactory.com:6006/uploads/user-profile-image/icons8-spotify-48.png"> </a>
                                                              </td>
                                                          </tr>
                                                      </tbody>
                                                  </table>
                                              </td>
                                          </tr>
                                      </tbody>
                                  </table>
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </td>
          </tr>
      </tbody>
  </table>`,
    };
    try {
      await transport.sendMail(mailOptions);
      const otpinsret = await userService.updateOtpUser(userId,otp);
      return true;
    } catch (e) {
      console.log("errrement:-----", e);
      return false;
    }
  };

module.exports = {
  transport,
  sendEmail,
  sendResetPasswordEmail,
  sendVerificationEmail,
  sendForgotOtpEmail
};
