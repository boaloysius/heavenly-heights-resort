import { createRouter, createWebHistory } from "vue-router";
import { useAuth } from "@/features/auth/composables/useAuth";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      component: () => import("@/layouts/RootLayout.vue"),
      children: [
        {
          path: "",
          name: "home",
          component: () => import("@/pages/Home.vue"),
        },
        {
          path: "about/",
          name: "about",
          component: () => import("@/pages/About.vue"),
        },
        {
          path: "cabins/",
          name: "cabins",
          component: () => import("@/pages/Cabins.vue"),
        },
        {
          path: "cabins/:cabinId/",
          name: "cabin",
          component: () => import("@/pages/Cabin.vue"),
        },
        {
          path: "login",
          name: "login",
          component: () => import("@/pages/Login.vue"),
        },
        {
          path: "register",
          name: "register",
          component: () => import("@/pages/Register.vue"),
        },
        {
          path: "logout",
          name: "logout",
          component: () => import("@/pages/Logout.vue"),
        },
        {
          path: "dashboard/",
          component: () => import("@/layouts/DashboardLayout.vue"),
          meta: { requiresAuth: true },
          children: [
            {
              path: "",
              redirect: "/dashboard/profile",
            },
            {
              path: "profile/",
              name: "profile",
              component: () => import("@/pages/Profile.vue"),
            },
            {
              path: "reservations/",
              name: "reservations",
              component: () => import("@/pages/Reservations.vue"),
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
