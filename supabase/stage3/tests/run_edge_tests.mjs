const { edgeTests: tests } = await import('./020_edge_function_tests.ts');

for (const test of tests) {
  await test.run();
  console.log(`PASS ${test.name}`);
}

console.log(`STAGE_3_EDGE_FUNCTION_TESTS_PASS count=${tests.length}`);
