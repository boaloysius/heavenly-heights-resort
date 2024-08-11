import { createApp } from "vue";
import { StatusCodes } from "http-status-codes";
import { VueQueryPlugin, QueryClient } from "@tanstack/vue-query";

import App from "./App.vue";
import router from "./router.js";
import "./style.css";
import "@fontsource/josefin-sans";

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 3,
      throwOnError: true,
    },
  },
});

const app = createApp(App);
app.use(VueQueryPlugin, { queryClient });
app.use(router);
app.config.errorHandler = (err) => {
  if (err?.status == StatusCodes.UNAUTHORIZED) {
    router.push({ name: "logout" });
  }
};
app.mount("#app");
