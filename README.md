# Automerge Syndrome

A Rails 7 application for the FitnessFormula marketing site. The app uses Rails 7, TailwindCSS, and Rails-focused RuboCop to present the selected FitnessFormula brand direction and landing page structure.

## Local setup

### Prerequisites

- Ruby version from `.ruby-version`
- Bundler
- SQLite-compatible local Rails environment

Install dependencies:

```sh
bundle install
```

Prepare the local database if this is a fresh checkout:

```sh
bin/rails db:prepare
```

Run the site locally:

```sh
bin/rails server
```

Open <http://localhost:3000/>.

For the Rails/Tailwind development process, use:

```sh
bin/dev
```

## Verification

Run the test suite:

```sh
bin/rails test
```

Build Tailwind assets when validating UI changes:

```sh
bin/rails tailwindcss:build
```

Run RuboCop:

```sh
bundle exec rubocop
```

## Deployment with Kamal on DigitalOcean

`config/deploy.yml` contains a reviewable Kamal configuration for deploying this Rails app to a DigitalOcean droplet with images stored in DigitalOcean Container Registry. The file intentionally uses placeholders instead of production values or credentials.

Before deploying, replace these placeholders with environment-specific values:

- `<KAMAL_APP_NAME>`: the Kamal service/app name, for example `fitnessformula`.
- `<DO_REGISTRY_NAME>` and `<DO_IMAGE_NAME>`: the DigitalOcean Container Registry name and image repository.
- `<DROPLET_IP>`: the target DigitalOcean droplet IP address.
- `<PRODUCTION_HOSTNAME>`: the hostname Kamal Proxy should terminate SSL for.
- `<DO_REGISTRY_USERNAME>`: the registry username or token username expected by DigitalOcean.

Provide sensitive values through the deploy environment rather than committing them:

```sh
export KAMAL_REGISTRY_PASSWORD=<DO_REGISTRY_PASSWORD>
export RAILS_MASTER_KEY=<PRODUCTION_RAILS_MASTER_KEY>
```

The Kamal config enables Rails production defaults needed by this app (`RAILS_ENV`, static file serving, stdout logging, and thread count), persists `storage/` for the SQLite production database and uploaded files, and sets `asset_path: /rails/public/assets` so compiled Rails/Tailwind assets remain compatible with production deploys. Run `bin/rails tailwindcss:build` locally when validating asset changes before a deploy.

## Selected design direction

FitnessFormula is presented as a confident, premium fitness brand with a direct path from interest to action. The page structure uses:

- A dark, high-contrast hero with gold brand accents for an energetic but polished first impression.
- Clear primary calls to action for booking a consultation and exploring programs.
- Video-led sections that show training and class energy instead of relying only on static imagery.
- Program cards for personal training, group classes, and nutrition coaching so visitors can quickly understand the offer.
- Social proof, simple outcomes, and direct contact cues to keep the landing page conversion-focused.

Architect rationale: the selected treatment keeps FitnessFormula aspirational without feeling exclusive. The gold accent system creates memorable brand ownership, the dark surfaces make motion assets feel cinematic, and the page order moves from motivation to program fit to trust-building proof before asking the visitor to act.

## Placeholder video policy

The current page uses Pexels-hosted placeholder videos for development and design reference only.

> Pexels hotlinking is temporary for development/reference only. Production videos should be uploaded to DigitalOcean Spaces and swapped into this centralized map.

Do not ship production traffic against Pexels hotlinks. Production videos should be hosted in DigitalOcean Spaces or another owned asset host where FitnessFormula controls availability, caching, CORS, and replacement timing.

## Replacing placeholder videos

The homepage keeps video URLs in a centralized map at the top of `app/views/home/index.html.erb`:

```erb
<% videos = {
  training: "https://videos.pexels.com/video-files/4761426/4761426-hd_1920_1080_25fps.mp4",
  classes: "https://videos.pexels.com/video-files/5319759/5319759-hd_1920_1080_25fps.mp4"
} %>
```

To swap in production assets:

1. Export each production video as a web-ready MP4, ideally compressed for the section where it appears.
2. Upload the files to DigitalOcean Spaces or another owned asset host.
3. Make each object readable by the site, either publicly or through the approved CDN delivery path.
4. Copy the final HTTPS asset URLs.
5. Replace the matching values in the `videos` map, for example:

```erb
<% videos = {
  training: "https://fitnessformula-assets.nyc3.cdn.digitaloceanspaces.com/videos/training-hero.mp4",
  classes: "https://fitnessformula-assets.nyc3.cdn.digitaloceanspaces.com/videos/group-classes.mp4"
} %>
```

6. Keep the keys (`training`, `classes`) unchanged unless the template is updated at the same time.
7. Run `bin/rails test`, `bin/rails tailwindcss:build`, and manually load the homepage to confirm the videos autoplay, loop, and remain muted.

If poster images are also replaced, update the `poster` attributes on the corresponding `<video>` elements in the same template.

## DigitalOcean Spaces CORS

Configure CORS on the Spaces bucket that serves production videos so the Rails site can request MP4 assets from the browser.

Use this exact JSON-style CORS policy as the reviewable baseline. Replace the origin values with the actual production and staging hosts before applying it:

```json
[
  {
    "AllowedOrigins": [
      "https://fitnessformula.com",
      "https://www.fitnessformula.com",
      "https://staging.fitnessformula.com",
      "http://localhost:3000"
    ],
    "AllowedMethods": ["GET", "HEAD"],
    "AllowedHeaders": ["*"],
    "ExposeHeaders": [
      "Accept-Ranges",
      "Content-Length",
      "Content-Range",
      "Content-Type",
      "ETag"
    ],
    "MaxAgeSeconds": 86400
  }
]
```

DigitalOcean control panel steps:

1. Open DigitalOcean, then go to **Spaces Object Storage**.
2. Select the Space that contains the production video assets.
3. Open **Settings** and find **CORS Configurations**.
4. Add a rule with origins `https://fitnessformula.com`, `https://www.fitnessformula.com`, `https://staging.fitnessformula.com`, and `http://localhost:3000`.
5. Allow methods `GET` and `HEAD`.
6. Allow headers `*`.
7. Expose `Accept-Ranges`, `Content-Length`, `Content-Range`, `Content-Type`, and `ETag`.
8. Set max age to `86400` seconds and save.

After saving, verify from a browser on the Rails site that the video requests return successful responses and include the expected `Access-Control-Allow-Origin` value for the current host.
