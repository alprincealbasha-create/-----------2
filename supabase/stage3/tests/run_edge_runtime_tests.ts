import { edgeTests } from './020_edge_function_tests.ts';

const results: Array<{ name: string; passed: boolean }> = [];
for (const test of edgeTests) {
  await test.run();
  results.push({ name: test.name, passed: true });
  console.log(`PASS ${test.name}`);
}

console.log(`STAGE_3_EDGE_FUNCTION_TESTS_PASS count=${results.length}`);

Deno.serve(() => Response.json({
  marker: 'STAGE_3_EDGE_FUNCTION_TESTS_PASS',
  count: results.length,
  results,
}));
