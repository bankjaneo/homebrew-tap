#!/usr/bin/env node
// Rewrites the version and sha256 lines in Casks/caprine.rb to match the
// latest release of bankjaneo/caprine. Exits 1 when the cask is already
// up-to-date (the workflow uses this to skip committing).
import {readFileSync, writeFileSync} from 'node:fs';

const repo = 'bankjaneo/caprine';
const caskPath = new URL('../Casks/caprine.rb', import.meta.url);

const release = await fetch(`https://api.github.com/repos/${repo}/releases/latest`)
	.then(response => {
		if (!response.ok) {
			throw new Error(`GitHub API returned ${response.status}`);
		}

		return response.json();
	});

const version = release.tag_name.replace(/^v/, '');
const digest = name => {
	const asset = release.assets.find(asset => asset.name === name);
	if (!asset?.digest?.startsWith('sha256:')) {
		throw new Error(`Missing sha256 digest for ${name} — did GitHub compute digests yet?`);
	}

	return asset.digest.slice('sha256:'.length);
};

const sha256 = {
	arm: digest(`Caprine-${version}-arm64.dmg`),
	intel: digest(`Caprine-${version}.dmg`),
};

const cask = readFileSync(caskPath, 'utf8');

if (cask.includes(`version "${version}"`)) {
	console.log(`Cask already at ${version}`);
	process.exit(1);
}

const updated = cask
	.replace(/version "[^"]+"/, `version "${version}"`)
	.replace(/sha256 arm:\s+"[0-9a-f]+",/, `sha256 arm:   "${sha256.arm}",`)
	.replace(/intel:\s+"[0-9a-f]+"/, `intel: "${sha256.intel}"`);

if (updated === cask) {
	throw new Error('Version changed but sha256 lines were not rewritten — check the regexes');
}

writeFileSync(caskPath, updated);
console.log(`Updated cask to ${version} (arm: ${sha256.arm.slice(0, 8)}…, intel: ${sha256.intel.slice(0, 8)}…)`);
