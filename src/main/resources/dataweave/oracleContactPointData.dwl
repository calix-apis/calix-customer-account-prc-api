%dw 2.0
output application/json
var contactPointData = {
    "email2": vars.contactData.*Email filter ((item, index) -> item.PrimaryFlag == "false" and (item.EndDate as Date {format: "uuuu-MM-dd"})>now() ),
   
"email": vars.contactData.*Email filter ((item, index) -> item.PrimaryFlag == "true" and (item.EndDate as Date {format: "uuuu-MM-dd"})>now() ),
   
    "phone" : vars.contactData.*Phone filter ((item, index) -> item.Status == "A" and (item.EndDate as Date {format: "uuuu-MM-dd"})>now() )
}
---
{
        "personId": vars.contactData.PartyId,
        
        "relationshipId": vars.contactData.Relationship.RelationshipId,
        
        "phone": (contactPointData.phone map ((item, index) ->  {
            "contactPointId": item.ContactPointId,
            "phoneNumber": item.PhoneNumber,
            "endDate": item.EndDate
        })),
        
        "email": (contactPointData.email map ((item, index) ->  {
            "contactPointId": item.ContactPointId,
            "primaryFlag": item.PrimaryFlag,
            "endDate": item.EndDate,
            "emailAddress": item.EmailAddress
        })),
        "email2": (contactPointData.email2 map ((item, index) ->  {
            "contactPointId": item.ContactPointId,
            "primaryFlag": item.PrimaryFlag,
            "endDate": item.EndDate,
            "emailAddress": item.EmailAddress
        }))
    }