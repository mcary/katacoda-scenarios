describe("My First Test", () => {
  before(() => {
    // This would start and visit the Lab being tested. Without
    // this the test will fail.
    cy.startScenario();
  });

  it("finds the title", () => {
    cy.contains("Rails Sandbox");
  });

  it("starts step 1", () => {
    cy.contains("Welcome!");
    cy.contains("Start").click();
    // Some text from step 1
    cy.contains("Let's get started with Ruby on Rails:");
  });

  it("has Ruby pre-installed", () => {
    cy.terminalType("ruby --version");
    cy.terminalShouldContain("ruby 3.2.2");
  });
});
