import * as esbuild from 'esbuild'
import { sassPlugin } from 'esbuild-sass-plugin'

const railsEnv = process.env.RAILS_ENV || 'development'
const optimize = railsEnv !== 'development'

const args = process.argv.slice(2);

const isWatchMode = args.includes('--watch');

const context = await esbuild.context({
  entryPoints: ["./app/javascript/application.js", "./app/javascript/admin.js"],
  outdir: "./app/assets/builds",
  color: true,
  minify: optimize,
  bundle: true,
  allowOverwrite: true,
  plugins: [sassPlugin({
    type: 'style',
    loadPaths: ['./node_modules']
  })],
  sourcemap: true,
  loader: { '.js': 'jsx' },
  publicPath: 'assets'
});

if (isWatchMode) {
  console.log('Watching for changes...');
  await context.watch()
} else {
  console.log('Building...');
  await context.rebuild()
  console.log('Done!');
  context.dispose()
}
