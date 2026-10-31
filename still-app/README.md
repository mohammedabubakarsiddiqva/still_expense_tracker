# Still: calm expense tracker (Supabase + Vercel)

Mobile-first static web app. Supabase provides sign-in and the database; Vercel hosts the files.
Each user's data is one row in `still_state`, protected by row-level security.

Files: index.html (app), config.js (your Supabase keys), supabase/schema.sql (database), vercel.json, manifest.webmanifest + icons (install on phone).

## 1. Supabase (database + login)
1. supabase.com > New project. Pick a name, a strong database password and the nearest region. Wait ~2 minutes.
2. Left menu > SQL Editor > New query. Paste all of `supabase/schema.sql`, press Run. You should see "Success".
3. Left menu > Table Editor: you should see `still_state` with a shield icon (RLS on).
4. Project Settings (gear) > API (or "API Keys"): copy the **Project URL** and the **anon / public** key.
   Never use the `service_role` key anywhere in this app.
5. Authentication > Sign In / Providers > Email: keep it enabled. While testing you may switch off "Confirm email" so sign-up works instantly.

## 2. Add your keys
Open `config.js` and replace the two placeholders:
    window.STILL_CONFIG={url:'https://abcd1234.supabase.co',key:'eyJ...your anon key...'};

## 3. Try it on your computer (optional)
In this folder run `npx serve` and open the address it prints. Create an account, add an expense, refresh: it should still be there.

## 4. Deploy on Vercel
Option A (GitHub, recommended)
1. Create a GitHub repo and upload the contents of this folder (index.html must be at the repo root).
2. vercel.com > Add New > Project > import the repo.
3. Framework Preset: Other. Build command: leave empty. Output directory: leave empty (root). Deploy.
Option B (command line): in this folder run `npx vercel`, accept the defaults, then `npx vercel --prod`.

## 5. Tell Supabase your live address
Authentication > URL Configuration: set **Site URL** to your Vercel URL (https://your-app.vercel.app) and add it under Redirect URLs. This matters for email-confirmation links.

## 6. Check on your phone
1. Open your Vercel URL on the phone, create an account (confirm the email if asked) and sign in.
2. Add an expense with the round + button. Open the same URL on your computer and sign in: it appears there too.
3. Install it: iPhone Safari > Share > Add to Home Screen. Android Chrome > menu > Install app.
4. Changing the code: edit, commit to GitHub, Vercel redeploys automatically.

## Troubleshooting
- "Add your Supabase project URL..." message: config.js still has placeholders, or was not redeployed.
- "Not saved: ..." under Settings > Account: schema.sql was not run, or you are not signed in.
- Sign-up says check your email but nothing arrives: turn off "Confirm email" while testing, or check spam.
- Data is last-write-wins: avoid editing on two devices at the same moment.
