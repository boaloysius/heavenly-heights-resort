<template>
  <AdvancedImage :cldImg="configuredImage" v-bind="attrs" :plugins="plugins" />
</template>

<script setup>
import { AdvancedImage } from "@cloudinary/vue";
import { lazyload, placeholder } from "@cloudinary/vue";
import { format, quality } from "@cloudinary/url-gen/actions/delivery";
import { Cloudinary } from "@cloudinary/url-gen";

const cloudName = import.meta.env.VITE_CLOUDINARY_CLOUD_NAME;

const cloudinary = new Cloudinary({
  cloud: {
    cloudName,
  },
});

const props = defineProps({
  publicId: {
    type: String,
    required: true,
  },
  plugins: {
    type: Array,
    default: () => [],
  },
  attrs: {
    type: Object,
    default: () => ({}),
  },
});

// Default plugins and actions
const defaultPlugins = [lazyload(), placeholder()];
const defaultActions = [format("auto"), quality("auto")];

// Configure the image with default settings
const configuredImage = cloudinary
  .image(props.publicId)
  .delivery(...defaultActions);

// Combine default plugins with any custom plugins
const plugins = [...defaultPlugins, ...(props.plugins || [])];
</script>
