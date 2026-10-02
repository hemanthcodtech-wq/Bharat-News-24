require('dotenv').config();
const nodemailer = require('nodemailer');
const pool = require('./db');

async function run() {
  try {
    console.log("Inserting a dummy news article into the database...");
    
    // Check if category exists, or create one for test
    const categoryRes = await pool.query("SELECT id FROM categories LIMIT 1");
    let category_id = null;
    if (categoryRes.rows.length > 0) {
      category_id = categoryRes.rows[0].id;
    } else {
      const newCat = await pool.query("INSERT INTO categories (name, slug) VALUES ('Test', 'test') RETURNING id");
      category_id = newCat.rows[0].id;
    }

    // Insert pending news article (simulating an employee submission)
    const title = "Test Article for Email Verification " + new Date().getTime();
    const result = await pool.query(
      `INSERT INTO news (title, slug, content, excerpt, image, author, category_id, is_published, is_trending, status, created_by)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, null) RETURNING *`,
      [title, "test-article-" + new Date().getTime(), "This is test content.", "Test excerpt", "", "Test Employee", category_id, true, false, 'pending']
    );

    console.log("Article inserted successfully! ID:", result.rows[0].id);

    console.log("Sending email...");
    const transporter = nodemailer.createTransport({
      host: process.env.SMTP_HOST || 'smtp.gmail.com',
      port: process.env.SMTP_PORT || 587,
      secure: false,
      auth: {
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASS,
      },
    });

    const mailOptions = {
      from: process.env.SMTP_USER,
      to: 'kancharlahemanth89@gmail.com', // Using the email you specified
      subject: `New News Submission: ${title}`,
      html: `
        <h3>New News Article Submitted for Review</h3>
        <p><strong>Title:</strong> ${title}</p>
        <p><strong>Submitted by:</strong> Test Employee</p>
        <br/>
        <p>Please log in to the admin dashboard to review and approve this article.</p>
      `
    };

    const info = await transporter.sendMail(mailOptions);
    console.log("Email sent successfully:", info.response);

  } catch (error) {
    console.error("Error:", error);
  } finally {
    pool.end();
  }
}

run();
