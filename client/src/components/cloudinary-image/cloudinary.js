import { Cloudinary } from "@cloudinary/url-gen";

const cloudName = import.meta.env.VITE_CLOUDINARY_CLOUD_NAME;

const cloudinary = new Cloudinary({
  cloud: {
    cloudName,
  },
});

export default cloudinary;
