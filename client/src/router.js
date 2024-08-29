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
          component: () => import("@/layouts/HomeLayout.vue"), // Use new layout
          children: [
            {
              path: "",
              name: "home",
              component: () => import("@/pages/Home.vue"),
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
          ],
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
            {
              path: "users/",
              name: "users",
              component: () => import("@/pages/Profiles.vue"),
              meta: { adminOnly: true },
            },
            {
              path: "users/:userId/bookings",
              name: "userBookings",
              component: () => import("@/pages/UserReservations.vue"),
              meta: { adminOnly: true },
            },
          ],
        },
      ],
    },
  ],
});

// Route guard to check for authentication and admin access
router.beforeEach((to, from, next) => {
  const { isAuthenticated, isAdmin } = useAuth();

  if (to.matched.some((record) => record.meta.requiresAuth)) {
    if (isAuthenticated.value) {
      // Check if the route requires admin access
      if (to.matched.some((record) => record.meta.adminOnly)) {
        if (isAdmin.value) {
          next(); // User is an admin, proceed to the route
        } else {
          next({ name: "home" }); // Redirect to the home page or any appropriate page for non-admin users
        }
      } else {
        next(); // Route requires authentication but not admin access, proceed
      }
    } else {
      next({ name: "login" }); // Redirect to the login page if not authenticated
    }
  } else {
    next(); // Proceed if the route doesn't require authentication
  }
});

// Set the document title before each route
router.beforeEach((to, from, next) => {
  const defaultTitle = "HH"; // Default title prefix
  const capitalize = (s) => s.charAt(0).toUpperCase() + s.slice(1);
  document.title = to.name
    ? `${defaultTitle} | ${capitalize(to.name)}`
    : defaultTitle;
  next();
});

export default router;
