process markduplicates {

        label 'markdup'

        publishDir "${params.outdir}/output/markdup"

        input:
        tuple val(name), path(bam)

        output:
        tuple val(name), path("*.markdup.bam"), emit: mark_dup
	path("*.txt"), emit: metrics

        script:
       
	"""

	gatk MarkDuplicates \
	--REMOVE_DUPLICATES false \
	--VALIDATION_STRINGENCY SILENT \
	--INPUT ${bam} \
	--METRICS_FILE ${name}.markdup.txt \
	--OUTPUT ${name}.markdup.bam

	gatk CollectBaseDistributionByCycle \
	-CHART ${name}.pdf \
	-I ${name}.markdup.bam \
	-O ${name}.txt

        """
}
