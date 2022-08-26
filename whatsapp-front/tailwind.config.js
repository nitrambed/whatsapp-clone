/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        'teal-green': '#075E54',
        'light-green': '#25D366'
      }
    }
  },
  plugins: []
}
