<?php
/**
 * Template part for displaying the post excerpt inside The Loop.
 *
 * @package Primer
 * @since   1.0.0
 */

?>

<div class="entry-summary">

	<?php the_excerpt(); ?>

	<p>
		<a class="button" href="<?php the_permalink(); ?>" aria-label="<?php /* translators: %s: Post title */ printf( esc_attr__( 'Continue reading %s', 'primer' ), get_the_title() ); ?>"><?php /* translators: %s: Left/Right arrow */ printf( esc_html__( 'Continue Reading %s', 'primer' ), is_rtl() ? '&larr;' : '&rarr;' ); ?></a>
	</p>

</div><!-- .entry-summary -->
