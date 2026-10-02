require('dotenv').config();
const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST || 'smtp.gmail.com',
  port: process.env.SMTP_PORT || 587,
  secure: false,
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASS,
  },
});

transporter.verify(function (error, success) {
  if (error) {
    console.error("Transporter Verification Error:", error);
  } else {
    console.log("Server is ready to take our messages");
    
    // Now try to send a test email
    transporter.sendMail({
      from: process.env.SMTP_USER,
      to: 'kancharlahemanth89@gmail.com',
      subject: 'Test Email from Bharath 24',
      text: 'This is a test email to verify SMTP configuration.'
    }, (err, info) => {
      if (err) {
        console.error("SendMail Error:", err);
      } else {
        console.log("Email sent successfully:", info.response);
      }
    });
  }
});
