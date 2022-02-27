import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";
import postcss from "./postcss.config.js";

export default defineConfig({
  define: {
    "process.env": process.env,
  },
  css: {
    postcss,
  },
  plugins: [react()],
  resolve: {
    alias: [
      {
        find: /^~.+/,
        replacement: val => {
          return val.replace(/^~/, "");
        },
      },
    ],
  },
  build: {
    commonjsOptions: {
      transformMixedEsModules: true,
    },
  },
  optimizeDeps: {
    exclude: ["ipfs-http-client", "electron-fetch"],
  },
});
