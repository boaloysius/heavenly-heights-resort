import { createRouter, createWebHistory } from "vue-router";

import RootLayout from "@/layouts/RootLayout.vue";
import About from "@/pages/About.vue";
import Cabins from "@/pages/Cabins.vue";
import Cabin from "@/pages/Cabin.vue";
import Home from "@/pages/Home.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      component: RootLayout,
      children: [
        {
          path: "",
          name: "home",
          component: Home,
        },
        {
          path: "about/",
          name: "about",
          component: About,
        },
        {
          path: "cabins/",
          name: "cabins",
          component: Cabins,
        },
        {
          path: "cabins/:cabinId/",
          name: "cabin",
          component: Cabin,
        },
      ],
    },
  ],
});

export default router;
