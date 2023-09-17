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

  it("Scented Blade should have an add to cart button.", () => {
    cy.get('[alt="Scented Blade"]').click()
    cy.get('button.btn').should('exist')
  })

  it("Visit cart page with one Scented Blade added.", () => {
    cy.get('[alt="Scented Blade"]').click()
    cy.get('button.btn').click()
    cy.get('a.nav-link[href="/cart"]').click()
    cy.get('tbody tr td:nth-child(4) div').invoke('text').then((qty) => {
      expect(qty.trim()).to.contain('1')
    })
  })

  it("Visit cart page with one Scented Blade added and add 5 more with + button.", () => {
    cy.get('[alt="Scented Blade"]').click()
    cy.get('button.btn').click()
    cy.get('a.nav-link[href="/cart"]').click()
    cy.contains('button', '+').click()
    cy.contains('button', '+').click()
    cy.contains('button', '+').click()
    cy.contains('button', '+').click()
    cy.contains('button', '+').click()
    cy.get('tbody tr td:nth-child(4) div').invoke('text').then((qty) => {
      expect(qty.trim()).to.contains('6')
    })
  })
})