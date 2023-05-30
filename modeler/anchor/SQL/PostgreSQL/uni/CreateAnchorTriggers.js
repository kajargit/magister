/*~
-- ANCHOR TRIGGERS ---------------------------------------------------------------------------------------------------
--
-- The following triggers on the latest view make it behave like a table.
-- There are three different 'instead of' triggers: insert, update, and delete.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent attributes, only changes that represent a value different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
~*/

var anchor, knot, attribute, equivalent;

while (anchor = schema.nextAnchor()) {
    if(anchor.hasMoreAttributes()) {
/*~    	

-- INSTEAD OF INSERT trigger ----------------------------------------------------------------------------------------------------
--DROP TRIGGER IF EXISTS iti_l$anchor.name ON $anchor.capsule\.l$anchor.name;
--DROP FUNCTION IF EXISTS $anchor.capsule\.iti_l$anchor.name();

CREATE OR REPLACE FUNCTION $anchor.capsule\.iti_l$anchor.name() RETURNS trigger AS '
    BEGIN

        -- create temporary table to keep inserted rows in
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_it_$anchor.name (
            $anchor.identityColumnName $anchor.identity not null,
            $(schema.METADATA)? $anchor.metadataColumnName $schema.metadata.metadataType not null,
    ~*/
                while (attribute = anchor.nextAttribute()) {
        /*~
                    $(schema.IMPROVED)? $attribute.anchorReferenceName $anchor.identity null,
                    $(schema.METADATA)? $attribute.metadataColumnName $schema.metadata.metadataType null,
                    $(attribute.timeRange)? $attribute.changingColumnName $attribute.timeRange null,
                    $(attribute.isEquivalent())? $attribute.equivalentColumnName $schema.metadata.equivalentRange null,
        ~*/
                    if(attribute.isKnotted()) {
                        knot = attribute.knot;
                        equivalent = schema.IMPROVED ? attribute.knotEquivalentColumnName : knot.equivalentColumnName;
        /*~
                    $attribute.knotValueColumnName $knot.dataRange null,
                    $(knot.hasChecksum())? $attribute.knotChecksumColumnName $schema.metadata.checksumType null,
                    $(knot.isEquivalent())? $equivalent $schema.metadata.equivalentRange null,
                    $(schema.METADATA)? $attribute.knotMetadataColumnName $schema.metadata.metadataType null,
                    $attribute.valueColumnName $knot.identity null$(anchor.hasMoreAttributes())?,
        ~*/
                    }
                    else {
        /*~
                    $attribute.valueColumnName $attribute.dataRange null$(anchor.hasMoreAttributes())?,
        ~*/
                    }
                }
        /*~
                ) ON COMMIT DROP;

        -- generate anchor ID (if not provided)
        IF (NEW.$anchor.identityColumnName IS NULL) THEN 
            INSERT INTO $anchor.capsule\.$anchor.name (
                $(schema.METADATA)? $anchor.metadataColumnName : $anchor.dummyColumnName
            ) VALUES (
                $(schema.METADATA)? NEW.$anchor.metadataColumnName : null
            );
            
            SELECT
                lastval() 
            INTO NEW.$anchor.identityColumnName;
        -- if anchor ID is provided then let''s insert it into the anchor table
        -- but only if that ID is not present in the anchor table
        ELSE
            INSERT INTO $anchor.capsule\.$anchor.name (
                $(schema.METADATA)? $anchor.metadataColumnName,
                $anchor.identityColumnName
            )
            SELECT
                $(schema.METADATA)? NEW.$anchor.metadataColumnName,
                NEW.$anchor.identityColumnName
            WHERE NOT EXISTS(
	            SELECT
	                $anchor.identityColumnName 
	            FROM $anchor.capsule\.$anchor.name
	            WHERE $anchor.identityColumnName = NEW.$anchor.identityColumnName
	            LIMIT 1
            );
        END IF;
    
        -- insert row into temporary table
    	INSERT INTO _tmp_it_$anchor.name (
            $anchor.identityColumnName,
            $(schema.METADATA)? $anchor.metadataColumnName,
~*/
        while (attribute = anchor.nextAttribute()) {
/*~
            $(schema.IMPROVED)? $attribute.anchorReferenceName,
            $(schema.METADATA)? $attribute.metadataColumnName,
            $(attribute.timeRange)? $attribute.changingColumnName,
            $(attribute.isEquivalent())? $attribute.equivalentColumnName,
~*/
            if(attribute.isKnotted()) {
                knot = attribute.knot;
                equivalent = schema.IMPROVED ? attribute.knotEquivalentColumnName : knot.equivalentColumnName;
/*~
            $attribute.knotValueColumnName,
            $(knot.hasChecksum())? $attribute.knotChecksumColumnName,
            $(knot.isEquivalent())? $equivalent,
            $(schema.METADATA)? $attribute.knotMetadataColumnName,
            $attribute.valueColumnName$(anchor.hasMoreAttributes())?,
~*/
            }
            else {
/*~
            $attribute.valueColumnName$(anchor.hasMoreAttributes())?,
~*/
            }
        }
/*~
    	) VALUES (
    	    NEW.$anchor.identityColumnName,
            $(schema.METADATA)? NEW.$anchor.metadataColumnName,
 ~*/
        while (attribute = anchor.nextAttribute()) {
/*~
            $(schema.IMPROVED)? COALESCE(NEW.$attribute.anchorReferenceName, NEW.$anchor.identityColumnName),
            $(schema.METADATA)? COALESCE(NEW.$attribute.metadataColumnName, NEW.$anchor.metadataColumnName),
            $(attribute.timeRange)? COALESCE(NEW.$attribute.changingColumnName, CAST($schema.metadata.now AS $attribute.timeRange)),
            $(attribute.isEquivalent())? COALESCE(NEW.$attribute.equivalentColumnName, 0),
~*/
            if(attribute.isKnotted()) {
                knot = attribute.knot;
                equivalent = schema.IMPROVED ? attribute.knotEquivalentColumnName : knot.equivalentColumnName;
/*~
            NEW.$attribute.knotValueColumnName,
            $(knot.hasChecksum())? COALESCE(NEW.$attribute.knotChecksumColumnName, $schema.metadata.encapsulation\.$schema.metadata.checksumFunction(CAST(NEW.$attribute.knotValueColumnName AS text))),
            $(knot.isEquivalent())? COALESCE(NEW.$equivalent, 0),
            $(schema.METADATA)? COALESCE(NEW.$attribute.knotMetadataColumnName, NEW.$anchor.metadataColumnName),
~*/
            }
/*~
            NEW.$attribute.valueColumnName$(anchor.hasMoreAttributes())?,
~*/
        }
/*~
    	);

        ~*/
        while (attribute = anchor.nextAttribute()) {
            knot = attribute.knot;
/*~
        INSERT INTO $attribute.capsule\.$attribute.name (
            $attribute.anchorReferenceName,
            $(schema.METADATA)? $attribute.metadataColumnName,
            $(attribute.timeRange)? $attribute.changingColumnName,
            $attribute.valueColumnName
        )
        SELECT
            i.$attribute.anchorReferenceName,
            $(schema.METADATA)? i.$attribute.metadataColumnName,
            $(attribute.timeRange)? i.$attribute.changingColumnName,
            $(attribute.isKnotted())? COALESCE(i.$attribute.valueColumnName, k$knot.mnemonic\.$knot.identityColumnName) : i.$attribute.valueColumnName
        FROM
            _tmp_it_$anchor.name i
~*/
            if(attribute.isKnotted()) {
                knot = attribute.knot;
/*~
        LEFT JOIN
            $knot.capsule\.$knot.name k$knot.mnemonic
        ON
            $(knot.hasChecksum())? k$knot.mnemonic\.$knot.checksumColumnName = i.$attribute.knotChecksumColumnName : k$knot.mnemonic\.$knot.valueColumnName = i.$attribute.knotValueColumnName
~*/
                if(knot.isEquivalent()) {
                    equivalent = schema.IMPROVED ? attribute.knotEquivalentColumnName : knot.equivalentColumnName;
/*~
        AND
            k$knot.mnemonic\.$knot.equivalentColumnName = i.$equivalent
~*/
                }
/*~
        WHERE
            COALESCE(i.$attribute.valueColumnName, k$knot.mnemonic\.$knot.identityColumnName) is not null;
~*/
            }
            else {
/*~
        WHERE
            i.$attribute.valueColumnName is not null;
~*/
            }
        }
/*~
        DROP TABLE IF EXISTS _tmp_it_$anchor.name;
    
        RETURN NEW;
    END;
' LANGUAGE plpgsql;

CREATE TRIGGER iti_l$anchor.name
INSTEAD OF INSERT ON $anchor.capsule\.l$anchor.name
FOR EACH ROW
EXECUTE PROCEDURE $anchor.capsule\.iti_l$anchor.name();

--INSTEAD OF UPDATE trigger ---------------------------------------------------------------------------------------------------------
--DROP TRIGGER IF EXISTS itu_l$anchor.name ON $anchor.capsule\.l$anchor.name;
--DROP FUNCTION IF EXISTS $anchor.capsule\.itu_l$anchor.name();

CREATE OR REPLACE FUNCTION $anchor.capsule\.itu_l$anchor.name() RETURNS trigger AS '

  BEGIN

   ~*/
    while (attribute = anchor.nextAttribute()) {
        knot = attribute.knot;

        if(attribute.isDeletable()) {
/*~        

        IF NEW.$attribute.valueColumnName IS NULL AND NEW.$attribute.deletableColumnName = 1 THEN

            CREATE TABLE IF NOT EXISTS $anchor.capsule\.$attribute.deletionName AS SELECT *, null::timestamp as $attribute.deletionTimeColumnName FROM $attribute.capsule\.$attribute.name WHERE FALSE;

            WITH tmp AS 
            (DELETE FROM $attribute.capsule\.$attribute.name WHERE $attribute.anchorReferenceName = OLD.$anchor.identityColumnName RETURNING *) 
	        INSERT INTO $anchor.capsule\.$attribute.deletionName SELECT *,  localtimestamp(0) FROM tmp where $attribute.anchorReferenceName = OLD.$anchor.identityColumnName;

        END IF;
       
~*/
        }
/*~
        IF NEW.$attribute.valueColumnName IS NOT NULL AND OLD.$attribute.valueColumnName <> NEW.$attribute.valueColumnName THEN   
~*/        

        if(attribute.timeRange){
/*~         
            INSERT INTO $attribute.capsule\.$attribute.name(
                $attribute.anchorReferenceName,
                $(attribute.isEquivalent())? $attribute.equivalentColumnName,
                $(schema.METADATA)?$attribute.metadataColumnName,
                $attribute.valueColumnName,
                $attribute.changingColumnName
            )VALUES(
                OLD.$anchor.identityColumnName,
                $(schema.METADATA)?NEW.$attribute.metadataColumnName,
                NEW.$attribute.valueColumnName,
                CASE 
                    WHEN OLD.$attribute.changingColumnName <> NEW.$attribute.changingColumnName THEN
                        NEW.$attribute.changingColumnName
                    ELSE
                        CAST($schema.metadata.now AS $attribute.timeRange)
                END
            );    

~*/
        }else {
/*~

            UPDATE $attribute.capsule\.$attribute.name
            SET $attribute.valueColumnName = NEW.$attribute.valueColumnName
            WHERE $attribute.anchorReferenceName = OLD.$anchor.identityColumnName;

~*/    
       } 
/*~
       END IF;
~*/            
    }
/*~    
    RETURN NEW;
  END;

' LANGUAGE plpgsql;

CREATE TRIGGER itu_l$anchor.name
INSTEAD OF UPDATE ON $anchor.capsule\.l$anchor.name
FOR EACH ROW
EXECUTE PROCEDURE $anchor.capsule\.itu_l$anchor.name();

--INSTEAD OF DELETE trigger ---------------------------------------------------------------------------------------------------------
--DROP TRIGGER IF EXISTS itd_l$anchor.name ON $anchor.capsule\.l$anchor.name;
--DROP FUNCTION IF EXISTS $anchor.capsule\.itd_l$anchor.name();

CREATE OR REPLACE FUNCTION $anchor.capsule\.itd_l$anchor.name() RETURNS trigger AS '

  BEGIN

~*/
     while (attribute = anchor.nextAttribute()) {
/*~   
    DELETE FROM $attribute.capsule\.$attribute.name $attribute.mnemonic
    WHERE 
          $(attribute.isEquivalent())? OLD.$attribute.equivalentColumnName = $attribute.mnemonic\.$attribute.equivalentColumnName
    $(attribute.isEquivalent())? AND
        $(attribute.timeRange)? OLD.$attribute.changingColumnName = $attribute.mnemonic\.$attribute.changingColumnName
    $(attribute.timeRange)? AND
        OLD.$attribute.anchorReferenceName = $attribute.mnemonic\.$attribute.anchorReferenceName;
~*/
    }
/*~
    DELETE FROM $anchor.capsule\.$anchor.name $anchor.mnemonic
    WHERE
        OLD.$anchor.identityColumnName = $anchor.mnemonic\.$anchor.identityColumnName$;
    RETURN NEW;
  END;

' LANGUAGE plpgsql;

CREATE TRIGGER itd_l$anchor.name
INSTEAD OF DELETE ON $anchor.capsule\.l$anchor.name
FOR EACH ROW
EXECUTE PROCEDURE $anchor.capsule\.itd_l$anchor.name();

~*/  
}
}