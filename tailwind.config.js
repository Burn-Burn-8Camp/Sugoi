module.exports = {

  purge: [],

  mode: 'jit',
  purge: [
    './app/**/*.html',
    './app/helpers/**/*.rb',
    './app/views/**/*.html.erb',
    './public/**/*.html',
    './app/**/*.{js,jsx,ts,tsx,vue}',
  ],

  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
