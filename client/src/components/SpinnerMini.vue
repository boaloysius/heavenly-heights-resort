<template>
  <div className="spinner-mini"></div>
</template>
<style scoped>
.spinner-mini {
  margin: 0;
  width: 20px;
  aspect-ratio: 1;
  border-radius: 50%;
  border: 2px solid theme("colors.primary.200");
  border-right-color: transparent;
  animation: rotate 1s infinite linear;
}

@keyframes rotate {
  to {
    transform: rotate(1turn);
  }
}
</style>
