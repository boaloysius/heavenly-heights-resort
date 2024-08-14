import { createRouter, createWebHistory } from "vue-router";

import RootLayout from "@/layouts/RootLayout.vue";
import About from "@/pages/About.vue";
import Cabins from "@/pages/Cabins.vue";
import Cabin from "@/pages/Cabin.vue";
import Home from "@/pages/Home.vue";
import Login from "@/pages/Login.vue";
import Register from "@/pages/Register.vue";
import DashboardLayout from "@/layouts/DashboardLayout.vue";
import Profile from "@/pages/Profile.vue";
import Reservations from "@/pages/Reservations.vue";
import Logout from "@/pages/Logout.vue";

import { useAuth } from "./features/auth/composables/useAuth";

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
        {
          path: "login",
          name: "login",
          component: Login,
        },
        {
          path: "register",
          name: "register",
          component: Register,
        },
        {
          path: "logout",
          name: "logout",
          component: Logout,
        },
        {
          path: "dashboard/",
          component: DashboardLayout,
          meta: { requiresAuth: true },
          children: [
            {
              path: "",
              redirect: "/dashboard/profile",
            },
            {
              path: "profile/",
              name: "profile",
              component: Profile,
            },
            {
              path: "reservations/",
              name: "reservations",
              component: Reservations,
            },
          ],
        },
      ],
    },
  ],
});

// Route guard to check for authentication
router.beforeEach((to, from, next) => {
  const { isAuthenticated } = useAuth();

  if (to.matched.some((record) => record.meta.requiresAuth)) {
    if (isAuthenticated.value) {
      next(); // Proceed to the route
    } else {
      next({ name: "login" }); // Redirect to the login page
    }
  } else {
    next(); // Proceed if the route doesn't require authentication
  }
});

export default router;
