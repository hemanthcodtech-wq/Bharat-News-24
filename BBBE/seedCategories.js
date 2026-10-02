const pool = require('./db');

const mainCategories = [
  { name: 'తెలంగాణ',         slug: 'telangana',       sort_order: 1,  show_in_header: true },
  { name: 'ఆంధ్రప్రదేశ్',    slug: 'andhra-pradesh',  sort_order: 2,  show_in_header: true },
  { name: 'జాతీయం',          slug: 'national',        sort_order: 3,  show_in_header: true },
  { name: 'అంతర్జాతీయం',     slug: 'international',   sort_order: 4,  show_in_header: true },
  { name: 'వినోదం',          slug: 'entertainment',   sort_order: 5,  show_in_header: true },
  { name: 'క్రీడలు',         slug: 'sports',          sort_order: 6,  show_in_header: true },
  { name: 'వ్యాపారం',        slug: 'business',        sort_order: 7,  show_in_header: true },
  { name: 'ఆరోగ్యం',         slug: 'health',          sort_order: 8,  show_in_header: true },
  { name: 'విద్య',           slug: 'education',       sort_order: 9,  show_in_header: true },
  { name: 'నేరాలు',          slug: 'crime',           sort_order: 10, show_in_header: true },
];

const subCategories = {
  'telangana': [
    { name: 'అదిలాబాద్',                   slug: 'adilabad',                sort_order: 1  },
    { name: 'భద్రాద్రి కొత్తగూడెం',         slug: 'bhadradri-kothagudem',    sort_order: 2  },
    { name: 'హనుమకొండ',                    slug: 'hanumakonda',             sort_order: 3  },
    { name: 'హైదరాబాద్',                   slug: 'hyderabad',               sort_order: 4  },
    { name: 'జగిత్యాల',                    slug: 'jagtial',                 sort_order: 5  },
    { name: 'జనగాం',                       slug: 'jangaon',                 sort_order: 6  },
    { name: 'జయశంకర్ భూపాలపల్లి',           slug: 'jayashankar-bhupalpally', sort_order: 7  },
    { name: 'జోగులాంబ గద్వాల',              slug: 'jogulamba-gadwal',        sort_order: 8  },
    { name: 'కామారెడ్డి',                   slug: 'kamareddy',               sort_order: 9  },
    { name: 'కరీంనగర్',                    slug: 'karimnagar',              sort_order: 10 },
    { name: 'ఖమ్మం',                       slug: 'khammam',                 sort_order: 11 },
    { name: 'కుమురం భీం ఆసిఫాబాద్',         slug: 'kumuram-bheem-asifabad',  sort_order: 12 },
    { name: 'మహబూబాబాద్',                  slug: 'mahabubabad',             sort_order: 13 },
    { name: 'మహబూబ్‌నగర్',                 slug: 'mahabubnagar',            sort_order: 14 },
    { name: 'మంచిర్యాల',                   slug: 'mancherial',              sort_order: 15 },
    { name: 'మెదక్',                       slug: 'medak',                   sort_order: 16 },
    { name: 'మేడ్చల్-మల్కాజ్‌గిరి',         slug: 'medchal-malkajgiri',      sort_order: 17 },
    { name: 'ములుగు',                      slug: 'mulugu',                  sort_order: 18 },
    { name: 'నాగర్‌కర్నూల్',               slug: 'nagarkurnool',            sort_order: 19 },
    { name: 'నల్గొండ',                     slug: 'nalgonda',                sort_order: 20 },
    { name: 'నారాయణపేట',                   slug: 'narayanpet',              sort_order: 21 },
    { name: 'నిర్మల్',                     slug: 'nirmal',                  sort_order: 22 },
    { name: 'నిజామాబాద్',                  slug: 'nizamabad',               sort_order: 23 },
    { name: 'పెద్దపల్లి',                  slug: 'peddapalli',              sort_order: 24 },
    { name: 'రాజన్న సిర్సిల్ల',            slug: 'rajanna-sircilla',        sort_order: 25 },
    { name: 'రంగారెడ్డి',                  slug: 'rangareddy',              sort_order: 26 },
    { name: 'సంగారెడ్డి',                  slug: 'sangareddy',              sort_order: 27 },
    { name: 'సిద్దిపేట',                   slug: 'siddipet',                sort_order: 28 },
    { name: 'సూర్యాపేట',                   slug: 'suryapet',                sort_order: 29 },
    { name: 'వికారాబాద్',                  slug: 'vikarabad',               sort_order: 30 },
    { name: 'వనపర్తి',                     slug: 'wanaparthy',              sort_order: 31 },
    { name: 'వరంగల్',                      slug: 'warangal',                sort_order: 32 },
    { name: 'యాదాద్రి భువనగిరి',            slug: 'yadadri-bhuvanagiri',     sort_order: 33 },
  ],
  'andhra-pradesh': [
    { name: 'అల్లూరి సీతారామరాజు',          slug: 'alluri-sitharama-raju',   sort_order: 1  },
    { name: 'అనకాపల్లి',                   slug: 'anakapalli',              sort_order: 2  },
    { name: 'అనంతపురము',                   slug: 'ananthapuramu',           sort_order: 3  },
    { name: 'అన్నమయ్య',                    slug: 'annamayya',               sort_order: 4  },
    { name: 'బాపట్ల',                      slug: 'bapatla',                 sort_order: 5  },
    { name: 'చిత్తూరు',                    slug: 'chittoor',                sort_order: 6  },
    { name: 'తూర్పు గోదావరి',               slug: 'east-godavari',           sort_order: 7  },
    { name: 'ఏలూరు',                       slug: 'eluru',                   sort_order: 8  },
    { name: 'గుంటూరు',                     slug: 'guntur',                  sort_order: 9  },
    { name: 'కాకినాడ',                     slug: 'kakinada',                sort_order: 10 },
    { name: 'కోనసీమ',                      slug: 'konaseema',               sort_order: 11 },
    { name: 'కృష్ణా',                      slug: 'krishna',                 sort_order: 12 },
    { name: 'కర్నూలు',                     slug: 'kurnool',                 sort_order: 13 },
    { name: 'నందయాల',                      slug: 'nandyal',                 sort_order: 14 },
    { name: 'ఎన్టీఆర్',                    slug: 'ntr',                     sort_order: 15 },
    { name: 'పల్నాడు',                     slug: 'palnadu',                 sort_order: 16 },
    { name: 'పార్వతీపురం మన్యం',            slug: 'parvathipuram-manyam',    sort_order: 17 },
    { name: 'ప్రకాశం',                     slug: 'prakasam',                sort_order: 18 },
    { name: 'శ్రీ బాలాజీ',                 slug: 'sri-balaji',              sort_order: 19 },
    { name: 'శ్రీ సత్యసాయి',               slug: 'sri-sathya-sai',          sort_order: 20 },
    { name: 'శ్రీకాకుళం',                  slug: 'srikakulam',              sort_order: 21 },
    { name: 'తిరుపతి',                     slug: 'tirupati',                sort_order: 22 },
    { name: 'విశాఖపట్నం',                  slug: 'visakhapatnam',           sort_order: 23 },
    { name: 'విజయనగరం',                    slug: 'vizianagaram',            sort_order: 24 },
    { name: 'పశ్చిమ గోదావరి',               slug: 'west-godavari',           sort_order: 25 },
    { name: 'వైఎస్సార్ కడప',               slug: 'ysr-kadapa',              sort_order: 26 },
  ],
  'national': [
    { name: 'రాజకీయం', slug: 'national-politics',  sort_order: 1 },
    { name: 'ఆర్థికం',  slug: 'national-economy',   sort_order: 2 },
    { name: 'న్యాయం',   slug: 'national-judiciary',  sort_order: 3 },
    { name: 'రక్షణ',    slug: 'national-defence',   sort_order: 4 },
  ],
  'international': [
    { name: 'ఆసియా',        slug: 'asia',        sort_order: 1 },
    { name: 'అమెరికా',      slug: 'america',     sort_order: 2 },
    { name: 'యూరప్',        slug: 'europe',      sort_order: 3 },
    { name: 'మిడిల్ ఈస్ట్', slug: 'middle-east', sort_order: 4 },
  ],
  'entertainment': [
    { name: 'సినిమా',    slug: 'cinema',     sort_order: 1 },
    { name: 'టెలివిజన్', slug: 'television', sort_order: 2 },
    { name: 'సంగీతం',   slug: 'music',      sort_order: 3 },
    { name: 'OTT',       slug: 'ott',        sort_order: 4 },
  ],
  'sports': [
    { name: 'క్రికెట్',  slug: 'cricket',   sort_order: 1 },
    { name: 'ఫుట్‌బాల్', slug: 'football',  sort_order: 2 },
    { name: 'కబడ్డీ',   slug: 'kabaddi',   sort_order: 3 },
    { name: 'ఒలింపిక్స్', slug: 'olympics', sort_order: 4 },
  ],
  'business': [
    { name: 'మార్కెట్లు',  slug: 'markets',    sort_order: 1 },
    { name: 'టెక్నాలజీ',   slug: 'technology', sort_order: 2 },
    { name: 'వ్యవసాయం',    slug: 'agriculture', sort_order: 3 },
    { name: 'స్టార్టప్స్', slug: 'startups',   sort_order: 4 },
  ],
  'health': [
    { name: 'వైద్యం', slug: 'medicine', sort_order: 1 },
    { name: 'యోగా',   slug: 'yoga',     sort_order: 2 },
    { name: 'ఆహారం',  slug: 'diet',     sort_order: 3 },
    { name: 'మందులు', slug: 'pharma',   sort_order: 4 },
  ],
  'education': [
    { name: 'పరీక్షలు',         slug: 'exams',        sort_order: 1 },
    { name: 'ఉద్యోగాలు',        slug: 'jobs',         sort_order: 2 },
    { name: 'స్కాలర్‌షిప్‌లు',  slug: 'scholarships', sort_order: 3 },
    { name: 'విశ్వవిద్యాలయాలు', slug: 'universities', sort_order: 4 },
  ],
  'crime': [
    { name: 'హత్య',         slug: 'murder',      sort_order: 1 },
    { name: 'మోసాలు',       slug: 'fraud',       sort_order: 2 },
    { name: 'సైబర్ నేరాలు', slug: 'cyber-crime', sort_order: 3 },
    { name: 'అక్రమ రవాణా',  slug: 'trafficking', sort_order: 4 },
  ],
};

async function seed() {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    console.log('🗑️  Removing old placeholder categories...');
    await client.query(`DELETE FROM categories WHERE slug = 'NEWS'`);

    console.log('📂  Inserting main categories...');
    const parentIdMap = {};

    for (const cat of mainCategories) {
      const res = await client.query(
        `INSERT INTO categories (name, slug, parent_id, sort_order, show_in_header)
         VALUES ($1, $2, NULL, $3, $4)
         ON CONFLICT (slug) DO UPDATE
           SET name = EXCLUDED.name,
               sort_order = EXCLUDED.sort_order,
               show_in_header = EXCLUDED.show_in_header
         RETURNING id`,
        [cat.name, cat.slug, cat.sort_order, cat.show_in_header]
      );
      parentIdMap[cat.slug] = res.rows[0].id;
      console.log(`   ✅ ${cat.name} (id=${res.rows[0].id})`);
    }

    console.log('\n📋  Inserting sub-categories...');
    let subCount = 0;

    for (const [parentSlug, subs] of Object.entries(subCategories)) {
      const parentId = parentIdMap[parentSlug];
      if (!parentId) { console.warn(`   ⚠️  Parent not found: ${parentSlug}`); continue; }
      for (const sub of subs) {
        await client.query(
          `INSERT INTO categories (name, slug, parent_id, sort_order, show_in_header)
           VALUES ($1, $2, $3, $4, false)
           ON CONFLICT (slug) DO UPDATE
             SET name = EXCLUDED.name,
                 parent_id = EXCLUDED.parent_id,
                 sort_order = EXCLUDED.sort_order`,
          [sub.name, sub.slug, parentId, sub.sort_order]
        );
        subCount++;
      }
      console.log(`   ✅ ${parentSlug} → ${subs.length} sub-categories`);
    }

    await client.query('COMMIT');
    console.log(`\n🎉 Done! Seeded ${mainCategories.length} main + ${subCount} sub-categories.`);
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('❌ Seed failed, rolled back:', err.message);
    process.exit(1);
  } finally {
    client.release();
    process.exit(0);
  }
}

seed();
