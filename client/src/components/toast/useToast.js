import { reactive } from "vue";

const toastState = reactive({
  toasts: [],
});

const generateId = () => `toast-${Math.random().toString(36).substr(2, 9)}`;

const show = (message, type = "success") => {
  const id = generateId();
  toastState.toasts.push({ id, message, type, visible: true });
  setTimeout(() => hide(id), 3000);
  return id;
};

const hide = (id) => {
  const index = toastState.toasts.findIndex((toast) => toast.id === id);
  if (index !== -1) {
    toastState.toasts.splice(index, 1);
  }
};

export function useToast() {
  return {
    toastState,
    show,
    hide,
  };
}
