namespace OrgChartGoogle.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Employees",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        nodeId = c.String(),
                        parentId = c.String(),
                        firstName = c.String(),
                        lastName = c.String(),
                        department = c.String(),
                        jobTitle = c.String(),
                        email = c.String(),
                        phone = c.String(),
                        image = c.String(),
                    })
                .PrimaryKey(t => t.id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.Employees");
        }
    }
}
