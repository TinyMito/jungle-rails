describe('Visit main page', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Visit Scented Blade is clickable", () => {
    cy.get('[alt="Scented Blade"]').click()
  })

  it("Scented Blade's link should land on correct product of page", () => {
    cy.get('[alt="Scented Blade"]').click()
    cy.get('h1').should('contain', 'Scented Blade')
  })

  it("Scented Blade should have 18 in stocks.", () => {
    cy.get('[alt="Scented Blade"]').click()
    cy.get('span').should('contain', '18')
  })

  it("Scented Blade cost $24.99 per unit.", () => {
    cy.get('[alt="Scented Blade"]').click()
    cy.get('span').should('contain', '$24.99')
  })

  it("Scented Blade should gave an add to cart button.", () => {
    cy.get('[alt="Scented Blade"]').click()
    cy.get('button.btn').should('exist')
  })
})