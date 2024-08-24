<template>
  <AdvancedImage :cldImg="configuredImage" v-bind="attrs" :plugins="plugins" />
</template>

<script setup>
import { AdvancedImage } from "@cloudinary/vue";
import { lazyload, placeholder } from "@cloudinary/vue";
import { format, quality } from "@cloudinary/url-gen/actions/delivery";
import { scale } from "@cloudinary/url-gen/actions/resize";
import cld from "./cloudinary";

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
const defaultPlugins = [lazyload(), placeholder({ mode: "blur" })];
const defaultActions = [format("auto"), quality("auto")];

let resize = scale();
if (props.attrs.width) {
  resize = resize.width(props.attrs.width);
}
if (props.attrs.height) {
  resize = resize.height(props.attrs.height);
}

// Configure the image with default settings
const configuredImage = cld
  .image(props.publicId)
  .resize(resize)
  .delivery(...defaultActions);

// Combine default plugins with any custom plugins
const plugins = [...defaultPlugins, ...(props.plugins || [])];
</script>
