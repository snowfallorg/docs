import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: "Snowfall",
      customCss: ["./src/styles/theme.css"],
      social: {
        github: "https://github.com/snowfallorg",
      },
      sidebar: [
        {
          label: "Lib",
          items: [
            { label: "Quickstart", link: "/guides/lib/quickstart/" },
            {
              label: "Guides",
              items: [
                { label: "Packages", link: "/guides/lib/packages/" },
                { label: "Overlays", link: "/guides/lib/overlays/" },
                { label: "Modules", link: "/guides/lib/modules/" },
                { label: "Systems", link: "/guides/lib/systems/" },
                { label: "Homes", link: "/guides/lib/homes/" },
                { label: "Library", link: "/guides/lib/library/" },
                { label: "Shells", link: "/guides/lib/shells/" },
                { label: "Generic", link: "/guides/lib/generic/" },
              ],
            },
            { label: "Reference", link: "/reference/lib/" },
            {
              label: "Migration",
              items: [{ label: "v2", link: "/guides/lib/migration/v2/" }],
            },
          ],
        },
        // {
        //   label: "Reference",
        //   autogenerate: { directory: "reference" },
        // },
      ],
    }),
  ],
});
