const defaultTheme = require("tailwindcss/defaultTheme")

module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js"
  ],
  theme: {
    extend: {
      colors: {
        "brand-green": "#4CAF50",
        "brand-purple": "#7B3F8C",
        "brand-gold": "#F5C518"
      },
      fontFamily: {
        sans: ["Inter", ...defaultTheme.fontFamily.sans]
      }
    }
  },
  plugins: []
}
